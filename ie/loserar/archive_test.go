package main

import (
	"bytes"
	"os"
	"path/filepath"
	"testing"
)

func TestNormalizeMemberName(t *testing.T) {
	cases := []struct {
		name string
		ok   bool
	}{
		{"docs/readme.txt", true}, {"./docs/readme.txt", true}, {"../secret", false}, {"..\\secret", false}, {"/tmp/file", false}, {"C:/secret", false}, {"docs/../../secret", false},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			_, err := normalizeMemberName(tc.name)
			if (err == nil) != tc.ok {
				t.Fatalf("normalizeMemberName(%q) error=%v, want ok=%v", tc.name, err, tc.ok)
			}
		})
	}
}

func TestArchiveRoundTripAndCorruption(t *testing.T) {
	dir := t.TempDir()
	source := filepath.Join(dir, "source")
	if err := os.MkdirAll(filepath.Join(source, "nested"), 0o755); err != nil {
		t.Fatal(err)
	}
	want := []byte("Loserar independent archive\n")
	if err := os.WriteFile(filepath.Join(source, "nested", "hello.txt"), want, 0o644); err != nil {
		t.Fatal(err)
	}
	archive := filepath.Join(dir, "sample.loser")
	entries, err := collectInputs(dir, []string{"source"})
	if err != nil {
		t.Fatal(err)
	}
	if err = writeArchive(archive, entries); err != nil {
		t.Fatal(err)
	}
	loaded, err := readArchive(archive)
	if err != nil {
		t.Fatal(err)
	}
	if err = validateEntries(loaded); err != nil {
		t.Fatal(err)
	}
	out := filepath.Join(dir, "out")
	if err = extractArchive(loaded, out, false); err != nil {
		t.Fatal(err)
	}
	got, err := os.ReadFile(filepath.Join(out, "source", "nested", "hello.txt"))
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(got, want) {
		t.Fatalf("content mismatch")
	}
	raw, err := os.ReadFile(archive)
	if err != nil {
		t.Fatal(err)
	}
	raw[len(raw)-1] ^= 0xff
	if err = os.WriteFile(archive, raw, 0o644); err != nil {
		t.Fatal(err)
	}
	loaded, err = readArchive(archive)
	if err != nil {
		t.Fatal(err)
	}
	if err = validateEntries(loaded); err == nil {
		t.Fatal("corrupt archive unexpectedly verified")
	}
}

func TestExtractRefusesOverwrite(t *testing.T) {
	dir := t.TempDir()
	archive := filepath.Join(dir, "a.loser")
	entries := []archiveEntry{{Entry: Entry{Name: "hello.txt", Kind: kindFile, Mode: 0o644, Size: 5, Stored: 5, Method: methodStore, CRC32: crc32Of([]byte("hello"))}, Data: []byte("hello")}}
	if err := writeArchive(archive, entries); err != nil {
		t.Fatal(err)
	}
	out := filepath.Join(dir, "out")
	if err := os.MkdirAll(out, 0o755); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(filepath.Join(out, "hello.txt"), []byte("old"), 0o644); err != nil {
		t.Fatal(err)
	}
	loaded, err := readArchive(archive)
	if err != nil {
		t.Fatal(err)
	}
	if err = extractArchive(loaded, out, false); err == nil {
		t.Fatal("overwrite was allowed")
	}
	if err = extractArchive(loaded, out, true); err != nil {
		t.Fatal(err)
	}
}

func crc32Of(data []byte) uint32 {
	var c uint32 = 0xffffffff
	for _, b := range data {
		c ^= uint32(b)
		for i := 0; i < 8; i++ {
			mask := uint32(0)
			if c&1 != 0 {
				mask = 0xedb88320
			}
			c = (c >> 1) ^ mask
		}
	}
	return ^c
}

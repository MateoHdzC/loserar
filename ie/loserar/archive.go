package main

import (
	"bufio"
	"compress/flate"
	"encoding/binary"
	"errors"
	"fmt"
	"hash/crc32"
	"io"
	"os"
	"path"
	"path/filepath"
	"sort"
	"strings"
	"time"
)

var (
	errInvalidArchive = errors.New("invalid or truncated archive")
	errUnsafePath     = errors.New("unsafe archive path")
)

const (
	magic         = "LOSR"
	formatVer     = uint16(1)
	maxNameSize   = 1 << 20
	maxEntries    = 1 << 24
	maxPayload    = 1 << 30
	methodStore   = byte(0)
	methodDeflate = byte(1)
	kindFile      = byte(0)
	kindDir       = byte(1)
)

type Entry struct {
	Name    string
	Kind    byte
	Mode    uint32
	ModTime time.Time
	Size    uint64
	Stored  uint64
	Method  byte
	CRC32   uint32
	Offset  int64
}

type archiveEntry struct {
	Entry
	Data []byte
}

func normalizeMemberName(name string) (string, error) {
	// Treat both separators as separators on every host so a macOS-created
	// archive cannot become traversal-prone when extracted on Windows.
	name = strings.ReplaceAll(name, "\\", "/")
	name = filepath.ToSlash(name)
	if name == "" || strings.HasPrefix(name, "/") || strings.HasPrefix(name, "\\") {
		return "", errUnsafePath
	}
	if len(name) >= 2 && name[1] == ':' {
		return "", errUnsafePath
	}
	clean := path.Clean(name)
	if clean == "." || clean == ".." || strings.HasPrefix(clean, "../") {
		return "", errUnsafePath
	}
	for _, part := range strings.Split(clean, "/") {
		if part == ".." || part == "" {
			return "", errUnsafePath
		}
	}
	return clean, nil
}

func safeJoin(root, member string) (string, error) {
	normalized, err := normalizeMemberName(member)
	if err != nil {
		return "", err
	}
	rootAbs, err := filepath.Abs(root)
	if err != nil {
		return "", err
	}
	target := filepath.Join(rootAbs, filepath.FromSlash(normalized))
	rel, err := filepath.Rel(rootAbs, target)
	if err != nil || rel == ".." || strings.HasPrefix(rel, ".."+string(filepath.Separator)) {
		return "", errUnsafePath
	}
	return target, nil
}

func collectInputs(root string, inputs []string) ([]archiveEntry, error) {
	rootAbs, err := filepath.Abs(root)
	if err != nil {
		return nil, err
	}
	entries := make(map[string]archiveEntry)
	for _, input := range inputs {
		walkRoot := input
		displayRoot := rootAbs
		if !filepath.IsAbs(input) {
			walkRoot = filepath.Join(root, input)
		} else {
			// Absolute inputs are named from their parent directory so the
			// archive never contains a machine-specific absolute path.
			displayRoot = filepath.Dir(filepath.Clean(input))
		}
		info, err := os.Stat(walkRoot)
		if err != nil {
			return nil, err
		}
		base := filepath.Base(filepath.Clean(walkRoot))
		if base == "." || base == string(filepath.Separator) {
			return nil, fmt.Errorf("invalid input %q", input)
		}
		err = filepath.Walk(walkRoot, func(full string, fi os.FileInfo, walkErr error) error {
			if walkErr != nil {
				return walkErr
			}
			if !fi.Mode().IsRegular() && !fi.IsDir() {
				return nil
			}
			rel, err := filepath.Rel(displayRoot, full)
			if err != nil {
				return err
			}
			name, err := normalizeMemberName(rel)
			if err != nil {
				return fmt.Errorf("%s: %w", rel, err)
			}
			if fi.IsDir() {
				entries[name] = archiveEntry{Entry: Entry{Name: name, Kind: kindDir, Mode: uint32(fi.Mode().Perm()), ModTime: fi.ModTime()}}
				return nil
			}
			data, err := os.ReadFile(full)
			if err != nil {
				return err
			}
			method, stored, err := compressPayload(data, flate.DefaultCompression)
			if err != nil {
				return err
			}
			entries[name] = archiveEntry{Entry: Entry{Name: name, Kind: kindFile, Mode: uint32(fi.Mode().Perm()), ModTime: fi.ModTime(), Size: uint64(len(data)), Stored: uint64(len(stored)), Method: method, CRC32: crc32.ChecksumIEEE(data)}, Data: stored}
			return nil
		})
		if err != nil {
			return nil, err
		}
		_ = info
	}
	result := make([]archiveEntry, 0, len(entries))
	for _, entry := range entries {
		result = append(result, entry)
	}
	sort.Slice(result, func(i, j int) bool { return result[i].Name < result[j].Name })
	return result, nil
}

func compressPayload(data []byte, level int) (byte, []byte, error) {
	var b strings.Builder
	w, err := flate.NewWriter(&b, level)
	if err != nil {
		return 0, nil, err
	}
	if _, err = w.Write(data); err != nil {
		return 0, nil, err
	}
	if err = w.Close(); err != nil {
		return 0, nil, err
	}
	compressed := []byte(b.String())
	if len(compressed) >= len(data) {
		return methodStore, append([]byte(nil), data...), nil
	}
	return methodDeflate, compressed, nil
}

func writeArchive(pathName string, entries []archiveEntry) error {
	tmp, err := os.CreateTemp(filepath.Dir(pathName), ".loserar-*")
	if err != nil {
		return err
	}
	tmpName := tmp.Name()
	defer os.Remove(tmpName)
	if err = writeArchiveTo(tmp, entries); err != nil {
		tmp.Close()
		return err
	}
	if err = tmp.Chmod(0o644); err != nil {
		tmp.Close()
		return err
	}
	if err = tmp.Close(); err != nil {
		return err
	}
	if err = os.Rename(tmpName, pathName); err != nil {
		return err
	}
	return nil
}

func writeArchiveTo(w io.Writer, entries []archiveEntry) error {
	if _, err := io.WriteString(w, magic); err != nil {
		return err
	}
	if err := binary.Write(w, binary.LittleEndian, formatVer); err != nil {
		return err
	}
	if err := binary.Write(w, binary.LittleEndian, uint16(0)); err != nil {
		return err
	}
	if uint64(len(entries)) > maxEntries {
		return fmt.Errorf("too many entries")
	}
	if err := binary.Write(w, binary.LittleEndian, uint32(len(entries))); err != nil {
		return err
	}
	for _, item := range entries {
		if _, err := normalizeMemberName(item.Name); err != nil {
			return err
		}
		if len(item.Name) > maxNameSize {
			return fmt.Errorf("member name too long")
		}
		if err := binary.Write(w, binary.LittleEndian, uint32(len(item.Name))); err != nil {
			return err
		}
		if _, err := io.WriteString(w, item.Name); err != nil {
			return err
		}
		if _, err := w.Write([]byte{item.Kind}); err != nil {
			return err
		}
		for _, value := range []any{item.Mode, item.ModTime.UnixNano(), item.Size, item.Stored, item.Method, item.CRC32} {
			if err := binary.Write(w, binary.LittleEndian, value); err != nil {
				return err
			}
		}
		if item.Kind == kindFile {
			if _, err := w.Write(item.Data); err != nil {
				return err
			}
		}
	}
	return nil
}

func readArchive(pathName string) ([]archiveEntry, error) {
	f, err := os.Open(pathName)
	if err != nil {
		return nil, err
	}
	defer f.Close()
	r := bufio.NewReader(f)
	magicBytes := make([]byte, len(magic))
	if _, err = io.ReadFull(r, magicBytes); err != nil || string(magicBytes) != magic {
		return nil, errInvalidArchive
	}
	var version, flags uint16
	var count uint32
	if binary.Read(r, binary.LittleEndian, &version) != nil || binary.Read(r, binary.LittleEndian, &flags) != nil || binary.Read(r, binary.LittleEndian, &count) != nil || version != formatVer || flags != 0 || count > maxEntries {
		return nil, errInvalidArchive
	}
	entries := make([]archiveEntry, 0, count)
	for i := uint32(0); i < count; i++ {
		var nameLen uint32
		if binary.Read(r, binary.LittleEndian, &nameLen) != nil || nameLen == 0 || nameLen > maxNameSize {
			return nil, errInvalidArchive
		}
		nameBytes := make([]byte, nameLen)
		if _, err = io.ReadFull(r, nameBytes); err != nil {
			return nil, errInvalidArchive
		}
		name, err := normalizeMemberName(string(nameBytes))
		if err != nil {
			return nil, errInvalidArchive
		}
		var kind byte
		if kind, err = r.ReadByte(); err != nil || (kind != kindFile && kind != kindDir) {
			return nil, errInvalidArchive
		}
		var mode uint32
		var nanos int64
		var size, stored uint64
		var method byte
		var crc uint32
		if binary.Read(r, binary.LittleEndian, &mode) != nil || binary.Read(r, binary.LittleEndian, &nanos) != nil || binary.Read(r, binary.LittleEndian, &size) != nil || binary.Read(r, binary.LittleEndian, &stored) != nil {
			return nil, errInvalidArchive
		}
		if stored > maxPayload || size > maxPayload {
			return nil, errInvalidArchive
		}
		if method, err = r.ReadByte(); err != nil || (kind == kindDir && (size != 0 || stored != 0)) || (kind == kindFile && method != methodStore && method != methodDeflate) {
			return nil, errInvalidArchive
		}
		if binary.Read(r, binary.LittleEndian, &crc) != nil {
			return nil, errInvalidArchive
		}
		data := make([]byte, stored)
		if kind == kindFile {
			if stored > uint64(^uint(0)>>1) {
				return nil, errInvalidArchive
			}
			if _, err = io.ReadFull(r, data); err != nil {
				return nil, errInvalidArchive
			}
		}
		entries = append(entries, archiveEntry{Entry: Entry{Name: name, Kind: kind, Mode: mode, ModTime: time.Unix(0, nanos), Size: size, Stored: stored, Method: method, CRC32: crc}, Data: data})
	}
	return entries, nil
}

func decodeEntry(item archiveEntry) ([]byte, error) {
	if item.Kind == kindDir {
		return nil, nil
	}
	var data []byte
	if item.Method == methodStore {
		data = append([]byte(nil), item.Data...)
	} else {
		r := flate.NewReader(strings.NewReader(string(item.Data)))
		var err error
		data, err = io.ReadAll(r)
		_ = r.Close()
		if err != nil {
			return nil, errInvalidArchive
		}
	}
	if uint64(len(data)) != item.Size || crc32.ChecksumIEEE(data) != item.CRC32 {
		return nil, errInvalidArchive
	}
	return data, nil
}

func validateEntries(entries []archiveEntry) error {
	seen := map[string]bool{}
	for _, item := range entries {
		if seen[item.Name] {
			return fmt.Errorf("duplicate member %q", item.Name)
		}
		seen[item.Name] = true
		if _, err := normalizeMemberName(item.Name); err != nil {
			return err
		}
		if _, err := decodeEntry(item); err != nil {
			return fmt.Errorf("%s: %w", item.Name, err)
		}
	}
	return nil
}

func extractArchive(entries []archiveEntry, destination string, force bool) error {
	if err := validateEntries(entries); err != nil {
		return err
	}
	if err := os.MkdirAll(destination, 0o755); err != nil {
		return err
	}
	if info, err := os.Lstat(destination); err != nil {
		return err
	} else if info.Mode()&os.ModeSymlink != 0 {
		return fmt.Errorf("symlink destination rejected: %s", destination)
	}
	for _, item := range entries {
		target, err := safeJoin(destination, item.Name)
		if err != nil {
			return err
		}
		if item.Kind == kindDir {
			if err := ensureNoSymlinkParents(destination, target); err != nil {
				return err
			}
			if info, err := os.Lstat(target); err == nil && info.Mode()&os.ModeSymlink != 0 {
				return fmt.Errorf("symlink target rejected: %s", target)
			}
			if err := os.MkdirAll(target, os.FileMode(item.Mode)); err != nil {
				return err
			}
			continue
		}
		if err := ensureNoSymlinkParents(destination, target); err != nil {
			return err
		}
		if info, err := os.Lstat(target); err == nil {
			if info.Mode()&os.ModeSymlink != 0 {
				return fmt.Errorf("symlink target rejected: %s", target)
			}
			if !force {
				return fmt.Errorf("refusing to overwrite %s", target)
			}
		}
		if err := os.MkdirAll(filepath.Dir(target), 0o755); err != nil {
			return err
		}
		data, err := decodeEntry(item)
		if err != nil {
			return err
		}
		if err := os.WriteFile(target, data, os.FileMode(item.Mode)); err != nil {
			return err
		}
		_ = os.Chtimes(target, item.ModTime, item.ModTime)
	}
	return nil
}

func ensureNoSymlinkParents(root, target string) error {
	rel, err := filepath.Rel(root, filepath.Dir(target))
	if err != nil {
		return err
	}
	current := root
	for _, part := range strings.Split(rel, string(filepath.Separator)) {
		if part == "." || part == "" {
			continue
		}
		current = filepath.Join(current, part)
		info, err := os.Lstat(current)
		if os.IsNotExist(err) {
			continue
		}
		if err != nil {
			return err
		}
		if info.Mode()&os.ModeSymlink != 0 {
			return fmt.Errorf("symlink parent rejected: %s", current)
		}
	}
	return nil
}

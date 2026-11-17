package main

import "testing"

func TestSplitShellWords(t *testing.T) {
	cases := []struct {
		name  string
		input string
		want  []string
		err   bool
	}{
		{name: "plain arguments", input: "create out.loser folder", want: []string{"create", "out.loser", "folder"}},
		{name: "double quoted path", input: `create out.loser "My Folder"`, want: []string{"create", "out.loser", "My Folder"}},
		{name: "escaped space", input: `cat archive.loser My\ File.txt`, want: []string{"cat", "archive.loser", "My File.txt"}},
		{name: "single quoted path", input: `list 'archive file.loser'`, want: []string{"list", "archive file.loser"}},
		{name: "unfinished quote", input: `create "out.loser`, err: true},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			got, err := splitShellWords(tc.input)
			if (err != nil) != tc.err {
				t.Fatalf("splitShellWords(%q) error=%v, want error=%v", tc.input, err, tc.err)
			}
			if err != nil {
				return
			}
			if len(got) != len(tc.want) {
				t.Fatalf("got %#v, want %#v", got, tc.want)
			}
			for index := range got {
				if got[index] != tc.want[index] {
					t.Fatalf("got %#v, want %#v", got, tc.want)
				}
			}
		})
	}
}

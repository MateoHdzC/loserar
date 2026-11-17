package main

import (
	"errors"
	"flag"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"runtime"
)

const version = "0.1.0"

var errUsage = errors.New("usage error")

func main() {
	if len(os.Args) == 1 && stdinIsTerminal() {
		interactiveShell(os.Stdout, os.Stderr)
		return
	}
	os.Exit(run(os.Args[1:], os.Stdout, os.Stderr))
}

func stdinIsTerminal() bool {
	info, err := os.Stdin.Stat()
	return err == nil && info.Mode()&os.ModeCharDevice != 0
}

func run(args []string, out, errOut io.Writer) int {
	noColor := false
	filtered := make([]string, 0, len(args))
	for _, arg := range args {
		if arg == "--no-color" {
			noColor = true
			continue
		}
		filtered = append(filtered, arg)
	}
	args = filtered
	for len(args) > 0 && (args[0] == "--version" || args[0] == "-h" || args[0] == "--help") {
		switch args[0] {
		case "--version":
			fmt.Fprintf(out, "loserar %s (%s/%s)\n", version, runtime.GOOS, runtime.GOARCH)
			return 0
		case "-h", "--help":
			printHelp(out)
			return 0
		}
	}
	if len(args) == 0 {
		printHelp(errOut)
		return 2
	}
	cmd := args[0]
	args = args[1:]
	var commandErr error
	switch cmd {
	case "create":
		commandErr = createCommand(args, out, noColor)
	case "list":
		commandErr = listCommand(args, out)
	case "test":
		commandErr = testCommand(args, out)
	case "extract":
		commandErr = extractCommand(args, out)
	case "cat":
		commandErr = catCommand(args, out)
	case "help":
		printHelp(out)
		return 0
	default:
		commandErr = fmt.Errorf("unknown command %q", cmd)
	}
	if commandErr != nil {
		fmt.Fprintf(errOut, "loserar: %v\n", commandErr)
		if errors.Is(commandErr, errUsage) {
			printHelp(errOut)
			return 2
		}
		return 1
	}
	return 0
}

func createCommand(args []string, out io.Writer, noColor bool) error {
	fs := flag.NewFlagSet("create", flag.ContinueOnError)
	fs.SetOutput(io.Discard)
	base := fs.String("C", ".", "base directory")
	level := fs.Int("level", -1, "compression level 0-9")
	if err := fs.Parse(args); err != nil {
		return errUsage
	}
	if fs.NArg() < 2 {
		return errUsage
	}
	if *level < -1 || *level > 9 {
		return fmt.Errorf("level must be between 0 and 9")
	}
	archive := fs.Arg(0)
	inputs := fs.Args()[1:]
	if filepath.Ext(archive) == "" {
		archive += ".loser"
	}
	entries, err := collectInputs(*base, inputs)
	if err != nil {
		return err
	}
	if *level >= 0 {
		for i := range entries {
			if entries[i].Kind == kindFile {
				data, err := decodeEntry(entries[i])
				if err != nil {
					return err
				}
				method, stored, err := compressPayload(data, *level)
				if err != nil {
					return err
				}
				entries[i].Method, entries[i].Data, entries[i].Stored = method, stored, uint64(len(stored))
			}
		}
	}
	if err := writeArchive(archive, entries); err != nil {
		return err
	}
	fmt.Fprintf(out, "%s created: %d entries\n", label("OK", noColor), len(entries))
	return nil
}

func listCommand(args []string, out io.Writer) error {
	if len(args) != 1 {
		return errUsage
	}
	entries, err := readArchive(args[0])
	if err != nil {
		return err
	}
	for _, item := range entries {
		kind := "file"
		if item.Kind == kindDir {
			kind = "dir"
		}
		fmt.Fprintf(out, "%-4s %10d  %s\n", kind, item.Size, item.Name)
	}
	return nil
}
func testCommand(args []string, out io.Writer) error {
	if len(args) != 1 {
		return errUsage
	}
	entries, err := readArchive(args[0])
	if err != nil {
		return err
	}
	if err = validateEntries(entries); err != nil {
		return err
	}
	fmt.Fprintf(out, "OK: %d entries verified\n", len(entries))
	return nil
}
func extractCommand(args []string, out io.Writer) error {
	fs := flag.NewFlagSet("extract", flag.ContinueOnError)
	fs.SetOutput(io.Discard)
	force := fs.Bool("force", false, "overwrite existing files")
	if err := fs.Parse(args); err != nil {
		return errUsage
	}
	if fs.NArg() < 1 || fs.NArg() > 2 {
		return errUsage
	}
	dest := "."
	if fs.NArg() == 2 {
		dest = fs.Arg(1)
	}
	entries, err := readArchive(fs.Arg(0))
	if err != nil {
		return err
	}
	if err = extractArchive(entries, dest, *force); err != nil {
		return err
	}
	fmt.Fprintf(out, "Extracted %d entries to %s\n", len(entries), dest)
	return nil
}
func catCommand(args []string, out io.Writer) error {
	if len(args) != 2 {
		return errUsage
	}
	entries, err := readArchive(args[0])
	if err != nil {
		return err
	}
	for _, item := range entries {
		if item.Name == args[1] {
			if item.Kind != kindFile {
				return fmt.Errorf("member is a directory")
			}
			data, err := decodeEntry(item)
			if err != nil {
				return err
			}
			_, err = out.Write(data)
			return err
		}
	}
	return fmt.Errorf("member not found: %s", args[1])
}

func label(value string, noColor bool) string {
	if noColor || os.Getenv("TERM") == "" {
		return value
	}
	return "\033[38;5;141m" + value + "\033[0m"
}
func printHelp(w io.Writer) {
	fmt.Fprintln(w, "Loserar — an independent, inspectable archive format")
	fmt.Fprintln(w, "Usage: loserar [--no-color] <command> [options]")
	fmt.Fprintln(w, "Commands:")
	fmt.Fprintln(w, "  create ARCHIVE PATH...   Create a .loser archive")
	fmt.Fprintln(w, "  list ARCHIVE             List members")
	fmt.Fprintln(w, "  test ARCHIVE             Verify integrity")
	fmt.Fprintln(w, "  extract ARCHIVE [DEST]   Extract safely (--force to overwrite)")
	fmt.Fprintln(w, "  cat ARCHIVE MEMBER       Write one member to stdout")
	fmt.Fprintln(w, "  --version                Print version")
	fmt.Fprintln(w, "Create options: -C DIR, --level 0..9")
}

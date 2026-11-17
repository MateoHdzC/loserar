package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"time"
)

const (
	ansiReset  = "\033[0m"
	ansiPurple = "\033[38;5;141m"
	ansiCyan   = "\033[38;5;81m"
	ansiGreen  = "\033[38;5;114m"
	ansiYellow = "\033[38;5;221m"
	ansiDim    = "\033[38;5;245m"
)

func interactiveShell(out, errOut io.Writer) {
	color := supportsColor()
	printBanner(out, color)
	showLoader(out, color, "warming archive core")
	fmt.Fprintf(out, "%s Type %s to see the console commands.\n\n", style("◆", ansiGreen, color), style("help", ansiCyan, color))

	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Fprint(out, shellPrompt(color))
		line, err := reader.ReadString('\n')
		if err != nil && len(strings.TrimSpace(line)) == 0 {
			break
		}
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}
		args, parseErr := splitShellWords(line)
		if parseErr != nil {
			fmt.Fprintf(errOut, "%s %v\n", style("error:", ansiYellow, color), parseErr)
			continue
		}
		if len(args) == 0 {
			continue
		}

		switch strings.ToLower(args[0]) {
		case "exit", "quit", "q":
			fmt.Fprintf(out, "\n%s %s\n", style("◆", ansiPurple, color), style("session closed", ansiDim, color))
			return
		case "help", "?":
			printShellHelp(out, color)
		case "banner":
			printBanner(out, color)
		case "clear", "cls":
			fmt.Fprint(out, "\033[2J\033[H")
			printBanner(out, color)
		case "theme":
			if len(args) != 2 || (args[1] != "on" && args[1] != "off") {
				fmt.Fprintln(errOut, "usage: theme on|off")
				continue
			}
			color = args[1] == "on"
			fmt.Fprintf(out, "%s theme %s\n", style("◆", ansiGreen, color), args[1])
		case "version":
			fmt.Fprintf(out, "loserar %s · %s/%s\n", version, runtime.GOOS, runtime.GOARCH)
		case "pwd":
			cwd, _ := os.Getwd()
			fmt.Fprintln(out, cwd)
		case "cd":
			changeDirectory(args, errOut)
		default:
			showLoader(out, color, "running "+args[0])
			if code := run(args, out, errOut); code != 0 {
				fmt.Fprintf(errOut, "%s command exited with %d\n", style("×", ansiYellow, color), code)
			}
		}
	}
}

func supportsColor() bool {
	return os.Getenv("NO_COLOR") == "" && (os.Getenv("TERM") != "" || os.Getenv("COLORTERM") != "")
}

func style(value, colorCode string, enabled bool) string {
	if !enabled || value == "" {
		return value
	}
	return colorCode + value + ansiReset
}

func shellPrompt(color bool) string {
	cwd, err := os.Getwd()
	if err != nil {
		cwd = "?"
	}
	if home, err := os.UserHomeDir(); err == nil {
		cwd = strings.Replace(cwd, home, "~", 1)
	}
	return fmt.Sprintf("%s %s %s ", style("loserar", ansiPurple, color), style("·", ansiDim, color), style(cwd+" ›", ansiCyan, color))
}

func printBanner(w io.Writer, color bool) {
	lines := []string{
		"╭────────────────────────────────────────────────────────────╮",
		"│  ◈  L O S E R A R   /   A R C H I V E   C O N S O L E      │",
		"│  ──────────────────────────────────────────────────────────  │",
		"│  independent format  ·  safe extraction  ·  v0.1.0         │",
		"╰────────────────────────────────────────────────────────────╯",
	}
	for index, line := range lines {
		code := ansiDim
		if index == 1 {
			code = ansiPurple
		}
		fmt.Fprintln(w, style(line, code, color))
	}
}

func showLoader(w io.Writer, color bool, label string) {
	frames := []string{"◒", "◓", "◑", "◐"}
	for _, frame := range frames {
		fmt.Fprintf(w, "\r%s %s", style(frame, ansiCyan, color), style(label, ansiDim, color))
		if color {
			time.Sleep(35 * time.Millisecond)
		}
	}
	fmt.Fprint(w, "\r\033[2K")
}

func printShellHelp(w io.Writer, color bool) {
	fmt.Fprintln(w, style("╭─ console commands ────────────────────────────────────────╮", ansiDim, color))
	fmt.Fprintln(w, "│  help       this panel       banner     redraw the logo     │")
	fmt.Fprintln(w, "│  clear      clear screen     theme on   enable colors      │")
	fmt.Fprintln(w, "│  pwd        show directory   cd PATH    change directory   │")
	fmt.Fprintln(w, "│  version    show build       exit       leave Loserar      │")
	fmt.Fprintln(w, style("╰───────────────────────────────────────────────────────────╯", ansiDim, color))
	fmt.Fprintln(w, "Archive commands: create, list, test, extract, cat")
	fmt.Fprintln(w, style("Tip: paths with spaces can be quoted: create out.loser \"My Folder\"", ansiYellow, color))
}

func changeDirectory(args []string, errOut io.Writer) {
	if len(args) != 2 {
		fmt.Fprintln(errOut, "usage: cd PATH")
		return
	}
	pathName := args[1]
	if pathName == "~" {
		if home, err := os.UserHomeDir(); err == nil {
			pathName = home
		}
	} else if strings.HasPrefix(pathName, "~/") {
		if home, err := os.UserHomeDir(); err == nil {
			pathName = filepath.Join(home, strings.TrimPrefix(pathName, "~/"))
		}
	}
	if err := os.Chdir(pathName); err != nil {
		fmt.Fprintf(errOut, "cd: %v\n", err)
	}
}

func splitShellWords(input string) ([]string, error) {
	var words []string
	var current strings.Builder
	var quote rune
	escaped := false
	flush := func() {
		if current.Len() > 0 {
			words = append(words, current.String())
			current.Reset()
		}
	}
	for _, char := range input {
		if escaped {
			current.WriteRune(char)
			escaped = false
			continue
		}
		if char == '\\' && quote != '\'' {
			escaped = true
			continue
		}
		if quote != 0 {
			if char == quote {
				quote = 0
			} else {
				current.WriteRune(char)
			}
			continue
		}
		switch char {
		case '\'', '"':
			quote = char
		case ' ', '\t', '\n', '\r':
			flush()
		default:
			current.WriteRune(char)
		}
	}
	if escaped {
		return nil, fmt.Errorf("unfinished escape")
	}
	if quote != 0 {
		return nil, fmt.Errorf("unfinished quote")
	}
	flush()
	return words, nil
}

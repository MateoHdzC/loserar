import AppKit
import Combine
import SwiftUI

@main
struct LoserarApp: App {
    var body: some Scene {
        WindowGroup("Loserar") {
            ContentView()
                .frame(minWidth: 680, minHeight: 520)
        }
    }
}

final class CLIClient: ObservableObject {
    @Published var output = "Choose an action to work with a .loser archive."
    @Published var isRunning = false

    func create() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = true
        panel.message = "Choose files or folders to archive"
        guard panel.runModal() == .OK, !panel.urls.isEmpty else { return }

        let save = NSSavePanel()
        save.allowedFileTypes = ["loser"]
        save.nameFieldStringValue = "archive.loser"
        guard save.runModal() == .OK, let destination = save.url else { return }
        run(["create", destination.path] + panel.urls.map(\.path))
    }

    func list() {
        guard let archive = chooseArchive() else { return }
        run(["list", archive.path])
    }

    func test() {
        guard let archive = chooseArchive() else { return }
        run(["test", archive.path])
    }

    func extract() {
        guard let archive = chooseArchive() else { return }
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.message = "Choose an extraction folder"
        guard panel.runModal() == .OK, let destination = panel.url else { return }
        run(["extract", archive.path, destination.path])
    }

    private func chooseArchive() -> URL? {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowedFileTypes = ["loser"]
        panel.message = "Choose a Loserar archive"
        guard panel.runModal() == .OK else { return nil }
        return panel.url
    }

    private func run(_ arguments: [String]) {
        guard !isRunning else { return }
        isRunning = true
        output = "Running: loserar " + arguments.joined(separator: " ") + "\n"
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let result = self?.execute(arguments) ?? (1, "Loserar is unavailable.")
            DispatchQueue.main.async {
                self?.output += result.1 + "\n\nExit code: \(result.0)"
                self?.isRunning = false
            }
        }
    }

    private func execute(_ arguments: [String]) -> (Int32, String) {
        let process = Process()
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        process.arguments = ["--no-color"] + arguments
        guard let executable = cliURL() else { return (1, "Bundled loserar CLI was not found.") }
        process.executableURL = executable
        do {
            try process.run()
            process.waitUntilExit()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return (process.terminationStatus, String(data: data, encoding: .utf8) ?? "(non-UTF-8 output)")
        } catch {
            return (1, "Could not start loserar: \(error.localizedDescription)")
        }
    }

    private func cliURL() -> URL? {
        let bundled = Bundle.main.bundleURL.appendingPathComponent("Contents/MacOS/loserar")
        if FileManager.default.isExecutableFile(atPath: bundled.path) { return bundled }
        let sibling = Bundle.main.bundleURL.deletingLastPathComponent().appendingPathComponent("loserar")
        if FileManager.default.isExecutableFile(atPath: sibling.path) { return sibling }
        let current = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("loserar")
        return FileManager.default.isExecutableFile(atPath: current.path) ? current : nil
    }
}

struct ContentView: View {
    @StateObject private var client = CLIClient()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 18) {
                LogoView()
                    .frame(width: 108, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                VStack(alignment: .leading, spacing: 6) {
                    Text("Loserar").font(.system(size: 34, weight: .bold, design: .rounded))
                    Text("A clean, independent archive workspace")
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            HStack(spacing: 12) {
                ActionButton(title: "Create", systemImage: "archivebox.fill", action: client.create)
                ActionButton(title: "Open / List", systemImage: "list.bullet.rectangle", action: client.list)
                ActionButton(title: "Extract", systemImage: "arrow.down.doc.fill", action: client.extract)
                ActionButton(title: "Test", systemImage: "checkmark.shield.fill", action: client.test)
            }
            .disabled(client.isRunning)

            Text("Command output")
                .font(.headline)
            ScrollView {
                Text(client.output)
                    .font(.system(.body, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
                    .padding(14)
            }
            .background(Color(nsColor: .textBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(28)
        .background(Color(nsColor: .windowBackgroundColor))
    }
}

struct LogoView: View {
    var body: some View {
        if let path = Bundle.main.path(forResource: "logo", ofType: "png"), let image = NSImage(contentsOfFile: path) {
            Image(nsImage: image).resizable().scaledToFill()
        } else if let path = Bundle.main.path(forResource: "logo", ofType: "webp"), let image = NSImage(contentsOfFile: path) {
            Image(nsImage: image).resizable().scaledToFill()
        } else {
            RoundedRectangle(cornerRadius: 18).fill(.purple.gradient)
                .overlay(Text("L").font(.largeTitle.bold()).foregroundStyle(.white))
        }
    }
}

struct ActionButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.purple)
    }
}

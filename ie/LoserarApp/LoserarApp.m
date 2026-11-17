#import <Cocoa/Cocoa.h>

@interface LoserarDelegate : NSObject <NSApplicationDelegate>
@property(nonatomic, strong) NSWindow *window;
@property(nonatomic, strong) NSTextView *outputView;
@property(nonatomic, copy) NSString *cliPath;
@end

@implementation LoserarDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSString *bundledCLI = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Contents/MacOS/loserar"];
    self.cliPath = [[NSFileManager defaultManager] isExecutableFileAtPath:bundledCLI] ? bundledCLI : @"loserar";

    NSRect frame = NSMakeRect(0, 0, 760, 560);
    self.window = [[NSWindow alloc] initWithContentRect:frame
                                               styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable)
                                                 backing:NSBackingStoreBuffered
                                                   defer:NO];
    self.window.title = @"Loserar";
    self.window.minSize = NSMakeSize(620, 440);

    NSView *content = self.window.contentView;
    NSImageView *logoView = [[NSImageView alloc] initWithFrame:NSMakeRect(28, 408, 112, 112)];
    logoView.imageScaling = NSImageScaleProportionallyUpOrDown;
    NSString *logoPath = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
    if (!logoPath) logoPath = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"webp"];
    logoView.image = [[NSImage alloc] initWithContentsOfFile:logoPath];
    [content addSubview:logoView];

    NSTextField *title = [[NSTextField alloc] initWithFrame:NSMakeRect(160, 463, 500, 40)];
    title.stringValue = @"Loserar";
    title.font = [NSFont systemFontOfSize:32 weight:NSFontWeightBold];
    title.bezeled = NO; title.drawsBackground = NO; title.editable = NO; title.selectable = NO;
    [content addSubview:title];

    NSTextField *subtitle = [[NSTextField alloc] initWithFrame:NSMakeRect(162, 437, 500, 24)];
    subtitle.stringValue = @"Independent archives for the terminal and desktop";
    subtitle.textColor = [NSColor secondaryLabelColor];
    subtitle.bezeled = NO; subtitle.drawsBackground = NO; subtitle.editable = NO; subtitle.selectable = NO;
    [content addSubview:subtitle];

    NSArray *buttons = @[
        [self buttonWithTitle:@"Create" action:@selector(createArchive:) frame:NSMakeRect(28, 370, 165, 38)],
        [self buttonWithTitle:@"Open / List" action:@selector(listArchive:) frame:NSMakeRect(205, 370, 165, 38)],
        [self buttonWithTitle:@"Extract" action:@selector(extractArchive:) frame:NSMakeRect(382, 370, 165, 38)],
        [self buttonWithTitle:@"Test" action:@selector(testArchive:) frame:NSMakeRect(559, 370, 165, 38)]
    ];
    for (NSButton *button in buttons) [content addSubview:button];

    NSTextField *outputLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(28, 332, 200, 24)];
    outputLabel.stringValue = @"Command output";
    outputLabel.font = [NSFont boldSystemFontOfSize:13];
    outputLabel.bezeled = NO; outputLabel.drawsBackground = NO; outputLabel.editable = NO; outputLabel.selectable = NO;
    [content addSubview:outputLabel];

    NSScrollView *scroll = [[NSScrollView alloc] initWithFrame:NSMakeRect(28, 28, 696, 294)];
    scroll.hasVerticalScroller = YES;
    scroll.borderType = NSBezelBorder;
    self.outputView = [[NSTextView alloc] initWithFrame:scroll.bounds];
    self.outputView.editable = NO;
    self.outputView.font = [NSFont userFixedPitchFontOfSize:12];
    self.outputView.string = @"Choose an action to work with a .loser archive.";
    scroll.documentView = self.outputView;
    [content addSubview:scroll];

    [self.window center];
    [self.window makeKeyAndOrderFront:nil];
}

- (NSButton *)buttonWithTitle:(NSString *)title action:(SEL)action frame:(NSRect)frame {
    NSButton *button = [[NSButton alloc] initWithFrame:frame];
    button.title = title;
    button.bezelStyle = NSBezelStyleRounded;
    button.target = self;
    button.action = action;
    return button;
}

- (NSArray<NSURL *> *)chooseItems {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseFiles = YES; panel.canChooseDirectories = YES; panel.allowsMultipleSelection = YES;
    panel.message = @"Choose files or folders to archive";
    return [panel runModal] == NSModalResponseOK ? panel.URLs : @[];
}

- (NSURL *)chooseArchive {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseFiles = YES; panel.canChooseDirectories = NO;
    panel.allowedFileTypes = @[@"loser"];
    panel.message = @"Choose a Loserar archive";
    return [panel runModal] == NSModalResponseOK ? panel.URL : nil;
}

- (void)createArchive:(id)sender {
    NSArray<NSURL *> *items = [self chooseItems];
    if (items.count == 0) return;
    NSSavePanel *save = [NSSavePanel savePanel];
    save.allowedFileTypes = @[@"loser"];
    save.nameFieldStringValue = @"archive.loser";
    if ([save runModal] != NSModalResponseOK || !save.URL) return;
    NSMutableArray *args = [NSMutableArray arrayWithObjects:@"--no-color", @"create", save.URL.path, nil];
    for (NSURL *url in items) [args addObject:url.path];
    [self runCLI:args];
}

- (void)listArchive:(id)sender { NSURL *archive = [self chooseArchive]; if (archive) [self runCLI:@[@"--no-color", @"list", archive.path]]; }
- (void)testArchive:(id)sender { NSURL *archive = [self chooseArchive]; if (archive) [self runCLI:@[@"--no-color", @"test", archive.path]]; }

- (void)extractArchive:(id)sender {
    NSURL *archive = [self chooseArchive];
    if (!archive) return;
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseFiles = NO; panel.canChooseDirectories = YES;
    panel.message = @"Choose an extraction folder";
    if ([panel runModal] == NSModalResponseOK && panel.URL) [self runCLI:@[@"--no-color", @"extract", archive.path, panel.URL.path]];
}

- (void)runCLI:(NSArray<NSString *> *)arguments {
    self.outputView.string = [NSString stringWithFormat:@"Running: loserar %@\n", [arguments componentsJoinedByString:@" "]];
    NSTask *task = [[NSTask alloc] init];
    task.executableURL = [NSURL fileURLWithPath:self.cliPath];
    task.arguments = arguments;
    NSPipe *pipe = [NSPipe pipe];
    task.standardOutput = pipe; task.standardError = pipe;
    @try {
        [task launch];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [task waitUntilExit];
            NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
            NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ?: @"(non-UTF-8 output)";
            dispatch_async(dispatch_get_main_queue(), ^{
                self.outputView.string = [NSString stringWithFormat:@"%@\nExit code: %d", text, task.terminationStatus];
            });
        });
    } @catch (NSException *exception) {
        self.outputView.string = [NSString stringWithFormat:@"Could not start loserar: %@", exception.reason];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender { return YES; }
@end

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSApplication *application = [NSApplication sharedApplication];
        LoserarDelegate *delegate = [[LoserarDelegate alloc] init];
        application.delegate = delegate;
        [application run];
    }
    return EXIT_SUCCESS;
}

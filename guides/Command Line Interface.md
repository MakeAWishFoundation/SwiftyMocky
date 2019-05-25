# Command Line Interface

**SwiftyMocky CLI** is a custom command line tool, writtten in swift, that will simplify setting up mock configuration, validating and troubleshooting configuration and simplify mocks generation.

## Usage:

```bash
$ .build/debug/swiftymocky <command>
```

## Commands:

+ `init` - Creates template of Mockfile to fill
+ `generate` - generate mocks. Usage 'swiftymocky options optional-mock-name'. Allowed flags:
    + `--disableCache`: disables using cahche
    + `--verbose`, `-v`: additional sourcery debug info
    + `--watch`, `-w`: run in watcher mode, allowed only if mock name specified
+ `watch` - run in watcher mode, allowed only if mock name specified
+ `setup` - if more than one xcodeproj in directory, add a selected project path:  `mocky setup <project>.xcodeproj`
+ `migrate` - migrate existing SwiftyMocky yml configurations into Mockfile™
+ `autoimport` - scans sources and automatically resolves imports for the mocks
+ `doctor` - run to inspect status of SwiftyMocky setup

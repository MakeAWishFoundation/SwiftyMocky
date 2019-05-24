# Adding generate action to XCode

Following these few simple steps, you can integrate mock generation with XCode, triggering it by key shortcut.

## 1. Prepare mock shell script

Create `mock.sh` file in project root directory, that will execute mock generation. We are wrapping all mock tasks in Rakefile, so we can just trigger `rake mock`.

// mock.sh
```bash
#!/bin/sh

swiftymocky generate
```

Make it executable, by executing in terminal:

```
chmod +x mock.sh
```

## 2. Add XCode behavior with key bindings

1. Open settings (`⌘ ,`)
1. Navigate to `Behaviors` tab
1. Tap little `+` on bottom of the behaviors list
1. Name your behavior (like "Generate Mock")
1. Press `⌘` (cmd) icon on the right part of added behavior entry.
1. Record shortcut
1. Select `Run` checkbox
1. Choose script from disk (If it is grayed out - it means it is not enabled to be executed. Look to step 1)
1. [optional] change sound notification, which will play when mock generation is finished

![Adding generate behavior][guide-add-generate]

## 3. Useage

Execute recorded shortcut, and watch stuff being done :)

<!-- Assets -->

[guide-add-generate]: ../guides/assets/guide-add-generate.gif "Adding generation behavior"

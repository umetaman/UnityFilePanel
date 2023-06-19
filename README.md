# UnityFilePanel

Unity NativePlugin to use native dialog on macOS.

This plugin aims to be easy to edit for Swift users.

- NSOpenPanel
  - Choose files/directories
  - Set choosable content types
- NSSavePanel
  - Set content types

## How to use

```cs
using UnityFilePanel;

// Open file
string path = Dialog.OpenFile(
    "Choose your file", "OK", "Choose your file", new[] { "txt" }, Application.dataPath);
var text = System.IO.File.ReadAllText(path);
Debug.Log(text);

// Save file
string path = Dialog.SaveFile(
    "Save your file", "SAVE", "Save your file", new[] { "txt" }, Application.dataPath);
System.IO.File.WriteAllText(path, "Hello, World!");
```

## License

The MIT License
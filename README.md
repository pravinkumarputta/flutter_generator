# Flutter Generator
Advanced dart/flutter dev tool for generating page, widget, model, repository, and bloc etc.

## Installing and updating flutter_generator
Globally install flutter_generator using pub:
```
dart pub global activate flutter_generator
```

## Commands
```
Usage: fg <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  bloc         Create flutter bloc.
  model        Create flutter model.
  page         Create flutter page.
  repository   Create flutter repository.
  widget       Create flutter widget.
```

### Bloc Command
```
Usage: flutter_generator bloc [arguments]
-h, --help                Print this usage information.
    --name (mandatory)    Create bloc with given name or full path.
```

### Model Command
```
Usage: flutter_generator model [arguments]
-h, --help                Print this usage information.
    --name (mandatory)    Create model with given name or full path.
    --dir-name            Create model folder with given name.
                          (defaults to "models")
    --with-dir            It creates flutter model with directory.
```

### Page Command
```
Usage: flutter_generator page [arguments]
-h, --help                Print this usage information.
    --name (mandatory)    Create page with given name or full path.
    --suffix              Appends the given suffix at the end of file.
                          (defaults to "page")
    --with-dir            It creates flutter page with directory.
```

### Repository Command
```
Usage: flutter_generator repository [arguments]
-h, --help                Print this usage information.
    --name (mandatory)    Create repository with given name or full path.
```

### Widget Command
```
Usage: flutter_generator widget [arguments]
-h, --help                Print this usage information.
    --name (mandatory)    Create widget with given name or full path.
    --stateful            Create stateful widget.
    --with-dir            It creates flutter widget with directory.
```

# License

[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

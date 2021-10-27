import 'package:args/command_runner.dart';

import 'model_template.dart';

class ModelCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = 'model';

  @override
  final description = 'Create flutter model.';

  ModelCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption(
      'name',
      mandatory: true,
      help: 'Create model with given name.',
    );
    argParser.addOption('dir-name',
        defaultsTo: 'models', help: 'Create model folder with given name.');
    argParser.addFlag(
      'with-dir',
      negatable: false,
      help: 'It creates flutter model with directory.',
    );
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    _createModel(argResults['name'].toLowerCase(), argResults['with-dir'],
        argResults['dir-name'].toLowerCase());
  }

  void _createModel(String name, bool withDir, String dirName) {
    if (withDir) {
      // create model with directory
      _createModelWithDir(name, dirName);
    } else {
      // create model without directory
      _createModelWithoutDir(name);
    }
  }

  void _createModelWithDir(String name, String dirName) {
    ModelTemplate().createDir(name, dirName: dirName);
  }

  void _createModelWithoutDir(String name) {
    ModelTemplate().create(name);
  }
}

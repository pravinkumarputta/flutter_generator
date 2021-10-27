import 'package:args/command_runner.dart';

import 'repository_template.dart';

class RepositoryCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = 'repository';

  @override
  final description = 'Create flutter repository.';

  RepositoryCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption(
      'name',
      mandatory: true,
      help: 'Create repository with given name.',
    );
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    RepositoryTemplate().create(argResults['name'].toLowerCase());
  }
}

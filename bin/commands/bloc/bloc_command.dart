import 'package:args/command_runner.dart';

import 'bloc_template.dart';

class BlocCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = 'bloc';

  @override
  final description = 'Create flutter bloc.';

  BlocCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption(
      'name',
      mandatory: true,
      help: 'Create bloc with given name.',
    );
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    BlocTemplate().create(argResults['name'].toLowerCase());
  }
}

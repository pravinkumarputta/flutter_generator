import 'package:args/command_runner.dart';

import '../../utils/common_utils.dart';
import 'widget_template.dart';

class WidgetCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = 'widget';

  @override
  final description = 'Create flutter widget.';

  WidgetCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption(
      'name',
      mandatory: true,
      help: 'Create widget with given name.',
    );
    argParser.addFlag('stateful',
        negatable: false, help: 'Create stateful widget.');
    argParser.addFlag(
      'with-dir',
      negatable: false,
      help: 'It creates flutter widget with directory.',
    );
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    _createWidget(argResults['name'].toLowerCase(), argResults['with-dir'],
        argResults['stateful']);
  }

  void _createWidget(String name, bool withDir, bool stateful) {
    if (withDir) {
      // create widget with directory
      _createWidgetWithDir(name, stateful);
    } else {
      // create widget without directory
      _createWidgetWithoutDir(name, stateful);
    }
  }

  void _createWidgetWithDir(String name, bool stateful) {
    WidgetTemplate().createDir(name, stateful: stateful);
  }

  void _createWidgetWithoutDir(String name, bool stateful) {
    // extract root path from name
    var namePath = CommonUtils.extractNamePath(name);
    WidgetTemplate().create(namePath.name, stateful: stateful, path: namePath.path);
  }
}

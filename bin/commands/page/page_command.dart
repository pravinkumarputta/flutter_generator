import 'package:args/command_runner.dart';

import 'page_template.dart';

class PageCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = 'page';

  @override
  final description = 'Create flutter page.';

  PageCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption(
      'name',
      mandatory: true,
      help: 'Create page with given name.',
    );
    argParser.addOption('suffix',
        defaultsTo: 'page',
        help: 'Appends the given suffix at the end of file.');
    argParser.addFlag(
      'with-dir',
      negatable: false,
      help: 'It creates flutter page with directory.',
    );
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    _createPage(argResults['name'].toLowerCase(),
        argResults['suffix'].toLowerCase(), argResults['with-dir']);
  }

  void _createPage(String name, String suffix, bool withDir) {
    if (withDir) {
      // create page with directory
      _createPageWithDir(name, suffix);
    } else {
      // create page without directory
      _createPageWithoutDir(name, suffix);
    }
  }

  void _createPageWithDir(String name, String suffix) {
    PageTemplate().createDir(name, suffix: suffix);
  }

  void _createPageWithoutDir(String name, String suffix) {
    PageTemplate().create(name, suffix: suffix);
  }
}

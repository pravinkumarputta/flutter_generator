import 'dart:io';
import 'package:args/command_runner.dart';

import 'commands/bloc/bloc_command.dart';
import 'commands/model/model_command.dart';
import 'commands/page/page_command.dart';
import 'commands/repo/repo_command.dart';
import 'commands/widget/widget_command.dart';

void main(List<String> arguments) {
  var runner = CommandRunner('flutter_generator',
      'Advanced flutter tool for generating pages, widgets, and modules etc.')
    ..addCommand(PageCommand())
    ..addCommand(BlocCommand())
    ..addCommand(RepositoryCommand())
    ..addCommand(ModelCommand())
    ..addCommand(WidgetCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64); // Exit code 64 indicates a usage error.
  });
  ;
}

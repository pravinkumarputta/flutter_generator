import 'dart:io';
import '../../utils/extensions.dart';

class WidgetTemplate {
  final _statelessTemplate = '''
import 'package:flutter/material.dart';

class @Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello');
  }
}
  ''';

  final _statefulTemplate = '''
import 'package:flutter/material.dart';

class @Name extends StatefulWidget {
  @override
  _@NameState createState() => _@NameState();
}

class _@NameState extends State<@Name> {
  @override
  Widget build(BuildContext context) {
    return Text("Hello");
  }
}
  ''';

  final _exportTemplate = '''
export '@name.dart';
  ''';

  void create(String name, {String path, bool stateful = false}) {
    var widgetName =
        name.split('_').map((e) => e.capitalize()).toList().join('');

    // use current dir if not provided
    path ??= Directory.current.path;

    // file path
    var filePath = path + '/' + name + '.dart';

    File(filePath)
      ..createSync()
      ..writeAsStringSync((stateful ? _statefulTemplate : _statelessTemplate)
          .replaceAll('@Name', widgetName));

    print('Widget created at ' + filePath);
  }

  void createDir(String name, {bool stateful = false}) {
    // set current dir path
    var path = Directory.current.path;

    // create root dir
    var widgetDirPath = path + '/widgets';
    Directory(widgetDirPath).createSync(recursive: true);

    // create widget
    create(name, path: widgetDirPath, stateful: stateful);

    // widget export file path
    var widgetExportFilePath = widgetDirPath + '/widgets.dart';

    // widget export write
    File(widgetExportFilePath)
      ..createSync()
      ..writeAsStringSync(_exportTemplate.replaceAll('@name', name));

    print('Widget export file created at ' + widgetExportFilePath);
  }
}

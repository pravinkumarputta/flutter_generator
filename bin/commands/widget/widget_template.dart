import 'dart:io';
import '../../utils/common_utils.dart';
import '../../utils/extensions.dart';

class WidgetTemplate {
  final _statelessTemplate = '''
import 'package:flutter/material.dart';

class @Name extends StatelessWidget {
  const @Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('@Name Widget');
  }
}
  ''';

  final _statefulTemplate = '''
import 'package:flutter/material.dart';

class @Name extends StatefulWidget {
  const @Name({Key? key}) : super(key: key);

  @override
  _@NameState createState() => _@NameState();
}

class _@NameState extends State<@Name> {
  @override
  Widget build(BuildContext context) {
    return const Text("@Name Widget");
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
    // extract root path from name
    var namePath = CommonUtils.extractNamePath(name);
    name = namePath.name;
    
    // set current dir path
    var path = namePath.path;

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

import 'dart:io';
import '../../utils/extensions.dart';

class PageTemplate {
  final _template = '''
import 'package:flutter/material.dart';

class @Name extends StatefulWidget {
  static route() => '@Name';

  @override
  _@NameState createState() => _@NameState();
}

class _@NameState extends State<@Name> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("@Name")
      ),
      body: Container(
        child: Text("Hello"),
      ),
    );
  }
}
  ''';

  final _exportTemplate = '''
export '@name.dart';
  ''';

  void create(String name, {String path, String suffix = 'page'}) {
    var pageName = (name + '_' + suffix)
        .split('_')
        .map((e) => e.capitalize())
        .toList()
        .join('');

    // use current dir if not provided
    path ??= Directory.current.path;

    // file path
    var filePath = path + '/' + name + '_' + suffix + '.dart';

    File(filePath)
      ..createSync()
      ..writeAsStringSync(_template.replaceAll('@Name', pageName));

    print('Page created at ' + filePath);
  }

  void createDir(String name, {String suffix = 'page'}) {
    // set current dir path
    var path = Directory.current.path;

    // create root dir
    var pageDirPath = path + '/' + name + '_' + suffix;
    Directory(pageDirPath).createSync(recursive: true);

    // create page
    create(name, path: pageDirPath);

    // create export template
    var pageName = name + '_' + suffix;

    // page export file path
    var pageExportFilePath = pageDirPath + '/$name.dart';

    // page export write
    File(pageExportFilePath)
      ..createSync()
      ..writeAsStringSync(_exportTemplate.replaceAll('@name', pageName));

    print('Page export file created at ' + pageExportFilePath);
  }
}

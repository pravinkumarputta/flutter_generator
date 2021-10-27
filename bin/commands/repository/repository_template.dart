import 'dart:io';
import '../../utils/extensions.dart';

class RepositoryTemplate {
  final _repoTemplate = '''
abstract class @NameRepository {
  Future<void> someMethod({param = 1});
}
  ''';

  final _repoImplTemplate = '''
import 'repository.dart';

class @NameRepositoryImpl extends @NameRepository {

  @NameRepositoryImpl();

  @override
  Future<void> someMethod({param = 1}) async {
    // do some operation
  }
}
  ''';

  final _repoExportTemplate = '''
export '@name_repository.dart';
export '@name_repository_impl.dart';
  ''';

  void create(String name, {String path}) {
    // set current dir path
    path ??= Directory.current.path;

    // create root dir
    var repoDirPath = path + '/' + 'repository';
    Directory(repoDirPath).createSync(recursive: true);

    // repo name
    var repoName = name.capitalize();

    // repo file path
    var repoFilePath = repoDirPath + '/' + name + '_repository.dart';

    // repo write
    File(repoFilePath)
      ..createSync()
      ..writeAsStringSync(_repoTemplate.replaceAll('@Name', repoName));

    print('Repository file created at ' + repoFilePath);

    // repo impl file path
    var repoImplFilePath = repoDirPath + '/' + name + '_repository_impl.dart';

    // repo impl write
    File(repoImplFilePath)
      ..createSync()
      ..writeAsStringSync(_repoImplTemplate.replaceAll('@Name', repoName));

    print('Repository Impl file created at ' + repoImplFilePath);

    // repo export file path
    var repoExportFilePath = repoDirPath + '/repository.dart';

    // repo export write
    File(repoExportFilePath)
      ..createSync()
      ..writeAsStringSync(_repoExportTemplate.replaceAll('@name', name));

    print('Repository export file created at ' + repoExportFilePath);
  }
}

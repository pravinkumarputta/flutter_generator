import 'dart:io';

class NamePath {
  final String name;
  final String path;

  NamePath(this.name, this.path);
}

class CommonUtils {
  static NamePath extractNamePath(String fullPath) {
    var nameParts = fullPath.split('/');
    var name = nameParts.removeLast();
    var rootPath = nameParts.join('/');
    
    // set current dir path
    var path = Directory.current.path + '/' + rootPath;

    return NamePath(name, path);
  }
}
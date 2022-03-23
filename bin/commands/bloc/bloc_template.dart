import 'dart:io';
import '../../utils/common_utils.dart';
import '../../utils/extensions.dart';

class BlocTemplate {
  final _blocStateTemplate = '''
import 'package:equatable/equatable.dart';

class @NameState extends Equatable {
  // state params
  final bool field1;
  final String field2;

  const @NameState({
    required this.field1,
    required this.field2,
  });

  @override
  List<Object?> get props => [
        field1,
        field2,
      ];

  @override
  String toString() {
    return \'''
    @NameState({
    field1: \$field1,
    field2: \$field2,
  })
    \''';
  }

  @NameState copyWith({
    field1,
    field2,
  }) {
    return @NameState(
      field1: field1 ?? this.field1,
      field2: field2 ?? this.field2,
    );
  }

  factory @NameState.empty() {
    return const @NameState(
      field1: true,
      field2: '',
    );
  }
}
  ''';

  final _blocEventTemplate = '''
import 'package:equatable/equatable.dart';

abstract class @NameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubEvent extends @NameEvent {
  final bool field1;
  final String field2;

  const SubEvent({
    required this.field1,
    required this.field2,
  });

  @override
  String toString() {
    return \'''
    SubEvent(
      field1: \$field1,
      field2: \$field2,
    )
    \''';
  }
}
  ''';

  final _blocTemplate = '''
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class @NameBloc extends Bloc<@NameEvent, @NameState> {

  @NameBloc() : super(@NameState.empty()) {
    // map events
    on<SubEvent>(_onSubEvent, transformer: sequential());
  }

  _onSubEvent(SubEvent event, Emitter<@NameState> emit) async {
    // update state
    emit(state.copyWith(field1: event.field1, field2: event.field2));
  }
}
  ''';

  final _blocExportTemplate = '''
export '@name_bloc.dart';
export '@name_event.dart';
export '@name_state.dart';
  ''';

  void create(String name, {String path}) {
    // extract root path from name
    var namePath = CommonUtils.extractNamePath(name);
    name = namePath.name;
    
    // set current dir path
    path ??= namePath.path;

    // create root dir
    var blocDirPath = path + '/' + 'bloc';
    Directory(blocDirPath).createSync(recursive: true);

    // bloc name
    var blocName = name.split('_').map((e) => e.capitalize()).toList().join('');

    // bloc state file path
    var blocStateFilePath = blocDirPath + '/' + name + '_state.dart';

    // bloc state write
    File(blocStateFilePath)
      ..createSync()
      ..writeAsStringSync(_blocStateTemplate.replaceAll('@Name', blocName));

    print('Bloc state file created at ' + blocStateFilePath);

    // bloc event file path
    var blocEventFilePath = blocDirPath + '/' + name + '_event.dart';

    // bloc event write
    File(blocEventFilePath)
      ..createSync()
      ..writeAsStringSync(_blocEventTemplate.replaceAll('@Name', blocName));

    print('Bloc event file created at ' + blocEventFilePath);

    // bloc file path
    var blocFilePath = blocDirPath + '/' + name + '_bloc.dart';

    // bloc bloc write
    File(blocFilePath)
      ..createSync()
      ..writeAsStringSync(_blocTemplate.replaceAll('@Name', blocName));

    print('Bloc file created at ' + blocFilePath);

    // bloc export file path
    var blocExportFilePath = blocDirPath + '/bloc.dart';

    // bloc export write
    File(blocExportFilePath)
      ..createSync()
      ..writeAsStringSync(_blocExportTemplate.replaceAll('@name', name));

    print('Bloc export file created at ' + blocExportFilePath);
  }
}

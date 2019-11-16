import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:dusza2019/other/database.dart';
import 'package:dusza2019/pojos/pojo_csv_student.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class GroupEvent extends Equatable {
  GroupEvent([List props = const []]) : super(props);
}

abstract class GroupState extends Equatable {
  GroupState([List props = const []]) : super(props);
}

class ReloadGroupEvent extends GroupEvent {
  @override
  String toString() => 'FetchGroupEvent';

  @override
  List<Object> get props => null;
}

class SyncWithGoogleDriveEvent extends GroupEvent {
  final String accessToken;

  SyncWithGoogleDriveEvent(this.accessToken);

  @override
  String toString() => 'SyncWithGoogleDriveEvent';

  @override
  List<Object> get props => null;
}

class AddGroupEvent extends GroupEvent {
  final String name;

  AddGroupEvent(this.name);

  @override
  String toString() => 'AddGroupEvent';

  @override
  List<Object> get props => null;
}

class RemoveGroupEvent extends GroupEvent {
  final PojoGroup group;

  RemoveGroupEvent(this.group);

  @override
  String toString() => 'RemoveGroupEvent';

  @override
  List<Object> get props => null;
}

class AddStudentEvent extends GroupEvent {
  final String name;
  final PojoGroup group;

  AddStudentEvent(this.name, this.group);

  @override
  String toString() => 'AddStudentEvent';

  @override
  List<Object> get props => null;
}

class RemoveStudentEvent extends GroupEvent {
  final PojoStudent student;
  final PojoGroup group;

  RemoveStudentEvent(this.student, this.group);

  @override
  String toString() => 'RemoveStudentEvent';

  @override
  List<Object> get props => null;
}

class AddGradeEvent extends GroupEvent {
  final int grade;
  final PojoStudent student;
  final PojoGroup group;

  AddGradeEvent(this.grade, this.student, this.group);

  @override
  String toString() => 'AddGradeEvent';

  @override
  List<Object> get props => null;
}

class RemoveGradeEvent extends GroupEvent {
  final int index;
  final PojoStudent student;
  final PojoGroup group;

  RemoveGradeEvent(this.index, this.student, this.group);

  @override
  String toString() =>
      'RemoveGradeEvent: ${index}, ${student.name}, ${group.name}';

  @override
  List<Object> get props => null;
}

class ImportCSVEvent extends GroupEvent {
  @override
  String toString() => 'ImportCSVEvent';

  @override
  List<Object> get props => null;
}

class InitialGroupState extends GroupEvent {
  @override
  String toString() => 'InitialGroupState';

  @override
  List<Object> get props => null;
}

class WaitingGroupState extends GroupState {
  @override
  String toString() => 'WaitingGroupState';

  @override
  List<Object> get props => null;
}

class LoadedGroupState extends GroupState {
  final List<PojoGroup> groups;

  LoadedGroupState(this.groups);

  @override
  String toString() => 'LoadedGroupState';

  @override
  List<Object> get props => null;
}

class GroupsBloc extends Bloc<GroupEvent, GroupState> {
  List<PojoGroup> _groups = List();

  @override
  GroupState get initialState => WaitingGroupState();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    print("Group Bloc event: ${event.toString()}");

    yield WaitingGroupState();

    switch (event.runtimeType) {
      case ReloadGroupEvent:
        _groups = await Database().getGroups();
        yield LoadedGroupState(_groups);
        break;

      case SyncWithGoogleDriveEvent:
        SyncWithGoogleDriveEvent e = event;
        await Database().syncWithGoogleDrive(e.accessToken);

        _groups = await Database().getGroups();
        yield LoadedGroupState(_groups);
        break;

      case AddGroupEvent:
        AddGroupEvent e = event;
        _addGroup(e.name);

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      case RemoveGroupEvent:
        RemoveGroupEvent e = event;
        _groups.removeWhere((group) => group.uuId == e.group.uuId);

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      case AddStudentEvent:
        AddStudentEvent e = event;
        _addStudent(e.name, e.group);

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      case RemoveStudentEvent:
        RemoveStudentEvent e = event;
        _groups
            .firstWhere((group) => group.uuId == e.group.uuId)
            .students
            .removeWhere((student) => student.id == e.student.id);

        yield LoadedGroupState(_groups);
        Database().saveGroups(_groups);
        break;

      case AddGradeEvent:
        AddGradeEvent e = event;
        _addGrade(e.grade, e.student, e.group);

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      case RemoveGradeEvent:
        RemoveGradeEvent e = event;
        PojoStudent student = _groups
            .firstWhere((group) => group.uuId == e.group.uuId)
            .students
            .firstWhere((student) => student.id == e.student.id);
        student.grades.removeAt(e.index);

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      case ImportCSVEvent:
        try {
          String filePath = await FilePicker.getFilePath(
              type: FileType.ANY, fileExtension: "");
          print(filePath);
          if (filePath != null) {
            final input = new File(filePath).openRead();
            final fields = await input
                .transform(utf8.decoder)
                .transform(new CsvToListConverter())
                .toList();

            List<CSVStudent> students = new List();
            for (List<dynamic> row in fields) {
              CSVStudent student = CSVStudent.fromRow(row);
              students.add(student);
            }

            List<PojoGroup> groups = students
                .map((CSVStudent student) {
                  return student.groupName;
                })
                .toSet()
                .map((String groupName) {
                  return _addGroup(groupName);
                })
                .toList();

            students.forEach((CSVStudent csvStudent) {
              PojoGroup group = groups.firstWhere((group) => group.name == csvStudent.groupName);
              PojoStudent student = _addStudent(csvStudent.name, group);
              for(int i = 0 ; i < csvStudent.gradesAmount ; i++){
                _addGrade(0, student, group);
              }
            });

            Database().saveGroups(_groups);
            yield LoadedGroupState(_groups);
          }
        } catch (ex) {
          print("Failed loading csv $ex");
        }

        yield LoadedGroupState(_groups);
        break;
    }

    print("Group Bloc currentstate: ${currentState.toString()}");
  }

  PojoGroup _addGroup(String name) {
    PojoGroup group = PojoGroup.fromName(name);
    _groups.add(group);
    return group;
  }

  PojoStudent _addStudent(String name, PojoGroup group) {
    print(group.name);
    print(group.uuId);
    int biggestId = 0;
    for (PojoStudent student in group.students) {
      if (biggestId < student.id) biggestId = student.id;
    }
    PojoStudent student = PojoStudent.fromName(name, biggestId + 1);
    _groups
        .firstWhere((matching) => matching.uuId == group.uuId)
        .students
        .add(student);
    return student;
  }

  void _addGrade(int grade, PojoStudent student, PojoGroup group) {
    PojoStudent matchingStudent = _groups
        .firstWhere((matching) => matching.uuId == group.uuId)
        .students
        .firstWhere((matching) => matching.id == student.id);
    matchingStudent.grades.add(grade);
  }
}

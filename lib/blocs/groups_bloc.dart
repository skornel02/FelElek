import 'package:bloc/bloc.dart';
import 'package:dusza2019/other/database.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:equatable/equatable.dart';



abstract class GroupEvent extends Equatable {
  GroupEvent([List props = const []]) : super(props);
}

abstract class GroupState extends Equatable {
  GroupState([List props = const []]) : super(props);
}

class ReloadGroupEvent extends GroupEvent {
  @override String toString() => 'FetchGroupEvent';
  @override
  List<Object> get props => null;
}

class SyncWithGoogleDriveEvent extends GroupEvent {
  final String accessToken;

  SyncWithGoogleDriveEvent(this.accessToken);

  @override String toString() => 'SyncWithGoogleDriveEvent';
  @override
  List<Object> get props => null;
}

class AddGroupEvent extends GroupEvent {
  final String name;

  AddGroupEvent(this.name);

  @override String toString() => 'AddGroupEvent';
  @override
  List<Object> get props => null;
}

class RemoveGroupEvent extends GroupEvent {
  final PojoGroup group;

  RemoveGroupEvent(this.group);

  @override String toString() => 'RemoveGroupEvent';
  @override
  List<Object> get props => null;
}

class AddStudentEvent extends GroupEvent {
  final String name;
  final PojoGroup group;

  AddStudentEvent(this.name, this.group);

  @override String toString() => 'AddUserEvent';
  @override
  List<Object> get props => null;
}

class RemoveStudentEvent extends GroupEvent {
  final PojoStudent student;
  final PojoGroup group;

  RemoveStudentEvent(this.student, this.group);

  @override String toString() => 'RemoveStudentEvent';
  @override
  List<Object> get props => null;
}

class AddGradeEvent extends GroupEvent {
  final int grade;
  final PojoStudent student;
  final PojoGroup group;

  AddGradeEvent(this.grade, this.student, this.group);

  @override String toString() => 'AddGradeEvent';
  @override
  List<Object> get props => null;
}

class RemoveGradeEvent extends GroupEvent {
  final int index;
  final PojoStudent student;
  final PojoGroup group;

  RemoveGradeEvent(this.index, this.student, this.group);

  @override String toString() => 'AddGradeEvent';
  @override
  List<Object> get props => null;
}

class InitialGroupState extends GroupEvent {
  @override String toString() => 'InitialGroupState';
  @override
  List<Object> get props => null;
}

class WaitingGroupState extends GroupState {
  @override String toString() => 'WaitingGroupState';
  @override
  List<Object> get props => null;
}
class LoadedGroupState extends GroupState {
  final List<PojoGroup> groups;

  LoadedGroupState(this.groups);

  @override String toString() => 'LoadedGroupState';
  @override
  List<Object> get props => null;


}


class GroupsBloc extends Bloc<GroupEvent, GroupState> {

  List<PojoGroup> _groups = List();

  @override
  GroupState get initialState => WaitingGroupState();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    yield WaitingGroupState();

    switch(event.runtimeType) {
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
        _groups.add(PojoGroup.fromName(e.name));

        _groups = List.from(_groups);
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
        int biggestId = 0;
        for(PojoStudent student in e.group.students) {
          if (biggestId < student.id)
            biggestId = student.id;
        }
        _groups.firstWhere((group) => group.uuId == e.group.uuId)
            .students.add(PojoStudent.fromName(e.name, biggestId + 1));

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      case RemoveStudentEvent:
        RemoveStudentEvent e = event;
        _groups.firstWhere((group) => group.uuId == e.group.uuId)
            .students.removeWhere((student) => student.id == e.student.id);

        yield LoadedGroupState(_groups);
        Database().saveGroups(_groups);
        break;

      case AddGradeEvent:
        AddGradeEvent e = event;
        PojoStudent student = _groups.firstWhere((group) => group.uuId == e.group.uuId)
            .students.firstWhere((student) => student.id == e.student.id);
        student.grades.add(e.grade);

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      case RemoveGradeEvent:
        RemoveGradeEvent e = event;
        PojoStudent student = _groups.firstWhere((group) => group.uuId == e.group.uuId)
            .students.firstWhere((student) => student.id == e.student.id);
        student.grades.removeAt(e.index);

        Database().saveGroups(_groups);
        yield LoadedGroupState(_groups);
        break;

      default:
        break;
    }
  }

}
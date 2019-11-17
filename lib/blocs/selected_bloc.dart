import 'package:bloc/bloc.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:equatable/equatable.dart';

abstract class PathEvent extends Equatable {
  PathEvent([List props = const []]) : super(props);
}

abstract class SelectedState extends Equatable {
  SelectedState([List props = const []]) : super(props);
}

class SetSelectedGroup extends PathEvent {
  final PojoGroup group;

  SetSelectedGroup(this.group);

  @override
  String toString() => 'SetSelectedGroupEvent';
}

class SetSelectedStudent extends PathEvent {
  final PojoStudent student;

  SetSelectedStudent(this.student);

  @override
  String toString() => 'SetStudentEvent';
}

class SetAbsentStudent extends PathEvent {
  final PojoStudent student;
  final bool absent;

  SetAbsentStudent(this.student, this.absent);

  @override
  String toString() => 'SetAbsentStudent';
}

class InitialPathState extends PathEvent {
  @override
  String toString() => 'InitialPathState';
}

class WaitingForSelection extends SelectedState {
  @override
  String toString() => 'WaitingPathState';
}

class SelectionReadyState extends SelectedState {
  final PojoGroup group;
  final PojoStudent student;
  final List<PojoStudent> absentStudents;

  SelectionReadyState(this.group, this.student, this.absentStudents);

  @override
  String toString() => 'LoadedPathState';
}

class SelectedBloc extends Bloc<PathEvent, SelectedState> {
  PojoGroup group;
  PojoStudent student;
  List<PojoStudent> absentStudents;

  @override
  SelectedState get initialState => WaitingForSelection();

  @override
  Stream<SelectedState> mapEventToState(PathEvent event) async* {
    yield WaitingForSelection();
    switch (event.runtimeType) {
      case SetSelectedGroup:
        SetSelectedGroup e = event;
        group = e.group;
        absentStudents = new List();

        yield SelectionReadyState(group, student, absentStudents);
        break;
      case SetSelectedStudent:
        SetSelectedStudent e = event;
        student = e.student;

        yield SelectionReadyState(group, student, absentStudents);
        break;
      case SetAbsentStudent:
        SetAbsentStudent e = event;
        if (e.absent) {
          absentStudents.add(e.student);
        } else {
          absentStudents.remove(e.student);
        }

        yield SelectionReadyState(group, student, absentStudents);
        break;
    }
  }
}

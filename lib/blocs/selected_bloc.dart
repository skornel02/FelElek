import 'package:bloc/bloc.dart';
import 'package:dusza2019/other/database.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
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

  @override String toString() => 'SetSelectedGroupEvent';
  @override
  List<Object> get props => null;
}


class SetSelectedStudent extends PathEvent {
  final PojoStudent student;

  SetSelectedStudent(this.student);

  @override String toString() => 'SetStudentEvent';
  @override
  List<Object> get props => null;
}


class InitialPathState extends PathEvent {
  @override String toString() => 'InitialPathState';
  @override
  List<Object> get props => null;
}
class WaitingForSelection extends SelectedState {
  @override String toString() => 'WaitingPathState';
  @override
  List<Object> get props => null;
}
class SelectionReadyState extends SelectedState {
  PojoGroup group;
  PojoStudent student;
  SelectionReadyState({this.group, this.student});

  @override String toString() => 'LoadedPathState';
  @override
  List<Object> get props => null;
}


class SelectedBloc extends Bloc<PathEvent, SelectedState> {

  PojoGroup group;
  PojoStudent student;

  @override
  SelectedState get initialState => WaitingForSelection();

  @override
  Stream<SelectedState> mapEventToState(PathEvent event) async* {
    yield WaitingForSelection();
    switch(event.runtimeType) {
      case SetSelectedGroup:
        SetSelectedGroup e = event;
        group = e.group;
        yield SelectionReadyState(group: group, student: student);
        break;
      case SetSelectedStudent:
        SetSelectedStudent e = event;
        student = e.student;
        yield SelectionReadyState(group: group, student: student);
        break;
    }
  }
}
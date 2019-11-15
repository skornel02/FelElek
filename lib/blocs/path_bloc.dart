import 'package:bloc/bloc.dart';
import 'package:dusza2019/other/database.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:equatable/equatable.dart';



abstract class PathEvent extends Equatable {
  PathEvent([List props = const []]) : super(props);
}

abstract class PathState extends Equatable {
  PathState([List props = const []]) : super(props);
}

class SetPathStudentEvent extends PathEvent {
  PojoStudent student;
  SetPathStudentEvent({this.student});
  @override String toString() => 'SetPathStudentEvent';
  @override
  List<Object> get props => null;
}

class SetPathGroupEvent extends PathEvent {
  PojoGroup group;
  SetPathGroupEvent({this.group});
  @override String toString() => 'SetPathGroupEvent';
  @override
  List<Object> get props => null;
}



class InitialPathState extends PathEvent {
  @override String toString() => 'InitialPathState';
  @override
  List<Object> get props => null;
}
class WaitingPathState extends PathState {
  @override String toString() => 'WaitingPathState';
  @override
  List<Object> get props => null;
}
class LoadedPathState extends PathState {
  PojoGroup group;
  PojoStudent student;
  LoadedPathState({this.group, this.student});

  @override String toString() => 'LoadedPathState';
  @override
  List<Object> get props => null;
}


class PathsBloc extends Bloc<PathEvent, PathState> {

  static final PathsBloc _singleton = new PathsBloc._internal();
  factory PathsBloc() {
    return _singleton;
  }
  PathsBloc._internal();

  PojoGroup group;
  PojoStudent student;

  @override
  PathState get initialState => WaitingPathState();

  @override
  Stream<PathState> mapEventToState(PathEvent event) async* {
    if (event is SetPathStudentEvent) {
        student = event.student;

        yield LoadedPathState(group: group, student: student);
    }

    if (event is SetPathGroupEvent) {
      group = event.group;

      yield LoadedPathState(group: group, student: student);
    }
  }
}
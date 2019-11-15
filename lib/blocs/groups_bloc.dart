import 'package:bloc/bloc.dart';
import 'package:dusza2019/other/database.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:equatable/equatable.dart';



abstract class GroupEvent extends Equatable {
  GroupEvent([List props = const []]) : super(props);
}

abstract class GroupState extends Equatable {
  GroupState([List props = const []]) : super(props);
}

class FetchGroupEvent extends GroupEvent {
  @override String toString() => 'FetchGroupEvent';
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
  final List<PojoGroup> _groups;

  LoadedGroupState(this._groups);

  @override String toString() => 'LoadedGroupState';
  @override
  List<Object> get props => _groups;
}


class GroupsBloc extends Bloc<GroupEvent, GroupState> {

  List<PojoGroup> groups;

  @override
  GroupState get initialState => WaitingGroupState();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is FetchGroupEvent) {
      try {
        yield WaitingGroupState();

        PojoGroup group = new PojoGroup("GG", "GG", new List(0));
        PojoGroup group2 = new PojoGroup("AA", "BB", new List(0));
        List<PojoGroup> groups = new List();
        groups.add(group);
        groups.add(group2);

        await Database().saveGroups(groups);

        groups = await Database().getGroups();
        print(groups);

        yield LoadedGroupState(groups);
      } on Exception catch(e){
        print("log: Exception: ${e.toString()}");
      }
    }
  }
}
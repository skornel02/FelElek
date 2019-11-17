import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupItemWidget extends StatelessWidget {
  final PojoGroup group;

  GroupItemWidget({this.group});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SelectedBloc>(context),
      builder: (BuildContext context, SelectedState state){
        bool isSelected = state is SelectionReadyState && state.group == group;
        return GestureDetector(
          onTap: (){
            SelectedBloc bloc = BlocProvider.of<SelectedBloc>(context);
            bloc.dispatch(SetSelectedGroup(isSelected ? null : group));
          },
          child: Card(
              color: isSelected ? Colors.grey : Theme.of(context).scaffoldBackgroundColor,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                  Padding(
                      padding: const EdgeInsets.only(left: 8, /*top: 4, bottom: 4*/),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(FontAwesomeIcons.times),
                            color: Colors.red,
                            onPressed: () async {
                              if(isSelected) {
                                SelectedBloc bloc = BlocProvider.of<SelectedBloc>(context);
                                bloc.dispatch(SetSelectedGroup(null));
                              }
                              await showDeleteGroupDialog(context, group);
                            },
                          ),
                          Text(group.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700
                            ),
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.edit),
                            onPressed: () {
                              BlocProvider.of<SelectedBloc>(context)
                                  .dispatch(SetSelectedGroup(group));
                              Navigator.pushNamed(context, "/student", arguments: group);
                            },
                          ),
                        ],
                      )
                  )
              )
          ),
        );
      },
    );
  }
}

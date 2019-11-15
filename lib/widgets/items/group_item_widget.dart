import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/path_bloc.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupItemWidget extends StatefulWidget{

  PojoGroup group;

  GroupItemWidget({this.group});


  @override
  State<StatefulWidget> createState()  => _GroupItemWidget();
}


class _GroupItemWidget extends State<GroupItemWidget> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        setState(() {
          isSelected = !isSelected;
        });
        if(isSelected){
          PathsBloc().dispatch(SetPathGroupEvent(group: widget.group));
        }else{
          if(isSelected){
            PathsBloc().dispatch(SetPathGroupEvent(group: null));
          }
        }
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
                            onPressed: (){
                              BlocProvider.of<GroupsBloc>(context)
                                  .dispatch(RemoveGroupEvent(widget.group));
                            },
                          ),
                          Text(widget.group.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700
                            ),
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.edit),
                            onPressed: (){
                              BlocProvider.of<GroupsBloc>(context)
                                  .dispatch(SetSelectedGroup(widget.group));
                              PathsBloc().dispatch(SetPathGroupEvent(group: widget.group));
                              Navigator.pushNamed(context, "/student", arguments: widget.group);
                            },
                          ),
                        ],
                      )
                  )
              )
      ),
    );
  }

}

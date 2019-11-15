import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupItemWidget extends StatelessWidget{

  PojoGroup group;

  GroupItemWidget({this.group});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: InkWell(
            onTap: () {
              Navigator.popAndPushNamed(context, "/group/groupId", arguments: group);
            },
            child:
            Align(
                alignment: Alignment.centerLeft,
                child:
                Padding(
                    padding: const EdgeInsets.only(left: 8, /*top: 4, bottom: 4*/),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(group.name,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700
                          ),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.edit),
                          onPressed: (){

                          },
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
}

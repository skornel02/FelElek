
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flutter/material.dart';

class SpinnerPage extends StatefulWidget {

  List<PojoStudent> choseStudents;

  SpinnerPage({Key key, this.choseStudents}) : super(key: key);

  @override
  _SpinnerPage createState() => _SpinnerPage();
}

class _SpinnerPage extends State<SpinnerPage> with AutomaticKeepAliveClientMixin {

  _SpinnerPage();
  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(

          body: SafeArea(
            child: Container()
          )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}



import 'package:dusza2019/blocs/google_login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../login_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocBuilder(
        bloc: BlocProvider.of<GoogleLoginBloc>(context),
        builder: (BuildContext context, GoogleLoginState state) {
          if (state is GoogleLoginSuccessfulState) {
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(state.email, style: TextStyle(fontSize: 18),),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.signOutAlt),
                      onPressed: () {
                        BlocProvider.of<GoogleLoginBloc>(context)
                            .dispatch(GoogleLoginResetEvent());
                      },
                    )
                  ],
                )
              ],
            );
          } else {
            return LoginWidget();
          }
        },
      ),
    ));
  }
}

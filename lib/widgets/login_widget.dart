import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../other/app_state_manager.dart';
import '../blocs/google_login_bloc.dart';
import 'dialogs/loading_dialog.dart';



class LoginWidget extends StatefulWidget {

  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidget createState() => _LoginWidget();
}

class _LoginWidget extends State<LoginWidget> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {


  GoogleLoginBloc googleLoginBloc;
  
  @override
  void initState() {
    super.initState();
    googleLoginBloc = GoogleLoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future proceedToApp(BuildContext context) async {
    // MainTabBlocs().initialize();
    await AppState.mainAppPartStartProcedure();
    Navigator.popAndPushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {

    Widget googleSignInButtonWidget = GoogleSignInButton(
      onPressed: (){
        googleLoginBloc.dispatch(GoogleLoginButtonPressedEvent());
      },
    );

    bool _isLoading = false;

    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: googleLoginBloc,
          listener: (context, state) async {
            if(state is GoogleLoginSuccessfulState){
              print("proceedToApp");
              await proceedToApp(context);
            }
            if(state is GoogleLoginWaitingState){
              _isLoading = true;
            }else{
              _isLoading = false;
            }
          },
        ),
      ],
      child: LoadingDialog(
        show: _isLoading,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[


              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
               /* child: SvgPicture.asset(
                  "assets/images/hatter-1.svg",
                  // semanticsLabel: 'Acme Logo'
                  fit: BoxFit.fitHeight,

                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                */
              ),

              Container(width: MediaQuery.of(context).size.width, height: 60, color: Colors.white,),



              /*
              Column(
                children: <Widget>[

                  Stack(
                    children: <Widget>[
                      SafeArea(
                        child: NotebookBackgroundWidget(),
                      ),

                      Image.asset(
                        'assets/images/Logo.png',
                      ),
                    ],
                  ),

                  Expanded(child: AutoSizeText(locText(context, key: "login"), style: TextStyle(/*fontSize: 60,*/ fontWeight: FontWeight.w800, color: HazizzTheme.blue, ), maxLines: 1, minFontSize: 44,)),

                ],
              ),
              */



              Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                googleSignInButtonWidget
                              ],
                            ),
                          ],
                        )
                    ),
                  )
              )
            ],
          ),
        ),
      ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

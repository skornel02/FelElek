import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/google_login_bloc.dart';
import 'dialogs/loading_dialog.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget googleSignInButtonWidget = GoogleSignInButton(
      onPressed: () {
        BlocProvider.of<GoogleLoginBloc>(context)
            .dispatch(GoogleLoginButtonPressedEvent());
      },
    );

    bool _isLoading = false;

    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: BlocProvider.of<GoogleLoginBloc>(context),
          listener: (context, state) async {
            if (state is GoogleLoginWaitingState) {
              _isLoading = true;
            } else {
              _isLoading = false;
            }
          },
        ),
      ],
      child: LoadingDialog(
        show: _isLoading,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[googleSignInButtonWidget],
        ),
      ),
    );
  }
}

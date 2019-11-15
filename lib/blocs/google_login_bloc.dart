import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bloc/bloc.dart';

/*
abstract class HEvent extends Equatable {
  HEvent([List props = const []]);
}
*/

abstract class GoogleLoginEvent extends Equatable {
  GoogleLoginEvent([List props = const []]) : super(props);
}

abstract class GoogleLoginState extends Equatable {
  GoogleLoginState([List props = const []]) : super(props);
}

class GoogleLoginButtonPressedEvent extends GoogleLoginEvent {
  @override String toString() => 'GoogleLoginButtonPressed';
  @override
  List<Object> get props => null;
}

class GoogleLoginResetEvent extends GoogleLoginEvent {
  @override String toString() => 'GoogleLoginResetEvent';
  @override
  List<Object> get props => null;
}

class GoogleLoginHaveToAcceptConditionsEvent extends GoogleLoginEvent {
  @override String toString() => 'GoogleLoginHaveToAcceptConditionsEvent';
  @override
  List<Object> get props => null;
}

class GoogleLoginAcceptedConditionsEvent extends GoogleLoginEvent {
  @override String toString() => 'GoogleLoginAcceptedConditionsEvent';
  @override
  List<Object> get props => null;
}

class GoogleLoginRejectConditionsEvent extends GoogleLoginEvent {
  @override String toString() => 'GoogleLoginRejectedConditionsState';
  @override
  List<Object> get props => null;
}



class GoogleLoginFineState extends GoogleLoginState {
  @override String toString() => 'GoogleLoginFineState';
  @override
  List<Object> get props => null;
}

class GoogleLoginPressedButtonState extends GoogleLoginState {
  @override String toString() => 'GoogleLoginFineState';
  @override
  List<Object> get props => null;
}
class GoogleLoginSuccessfulState extends GoogleLoginState {
  @override String toString() => 'GoogleLoginSuccessfulState';
  @override
  List<Object> get props => null;
}

class GoogleLoginWaitingState extends GoogleLoginState {
  @override String toString() => 'GoogleLoginWaitingState';
  @override
  List<Object> get props => null;
}

class GoogleLoginFailedState extends GoogleLoginState {
  GoogleLoginFailedState() : super([]);

  @override String toString() => 'GoogleLoginFailedState';
  @override
  List<Object> get props => [];
}

class GoogleLoginAcceptedConditionsState extends GoogleLoginState {
  @override String toString() => 'GoogleLoginAcceptedConditionsState';
  @override
  List<Object> get props => null;
}

class GoogleLoginRejectedConditionsState extends GoogleLoginState {
  @override String toString() => 'GoogleLoginRejectedConditionsState';
  @override
  List<Object> get props => null;
}

class GoogleLoginHaveToAcceptConditionsState extends GoogleLoginState {
  @override String toString() => 'GoogleLoginHaveToAcceptConditionsState';
  @override
  List<Object> get props => null;
}


class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {

  String _socialToken;

  GoogleSignIn _googleSignIn;
  FirebaseAuth _auth;



  GoogleLoginBloc(){
    _googleSignIn = GoogleSignIn(scopes: [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/userinfo.profile",
      "openid"
    ]);
    _auth = FirebaseAuth.instance;


  }


  GoogleLoginState get initialState => GoogleLoginFineState();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void reset(){
    this.dispatch(GoogleLoginResetEvent());
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }


  @override
  Stream<GoogleLoginState> mapEventToState(GoogleLoginEvent event) async* {

    if (event is GoogleLoginButtonPressedEvent) {
      yield GoogleLoginWaitingState();

      _socialToken = null;

      try{

        print("google login: 1");
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

        print("google login: 2");

        print("google login: 3");

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        print("google login: 4");

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print("google login: 5");


        // final AuthResult authResult = (await _auth.signInWithCredential(credential));
        // FirebaseUser user = authResult.user;
        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        print("signed in " + user.displayName);

        _socialToken = googleAuth.idToken;

        print("google login: success: openIdToken is not null: ${_socialToken != null}");

        if(_socialToken == null && _socialToken == "canceled"){
          Crashlytics().recordError(Exception("Social Token is null"), StackTrace.current, context: "Social Token is null");
          yield GoogleLoginFineState();
        }
      }catch(exception, stacktrace){
        Crashlytics().recordError(exception, stacktrace);
        yield GoogleLoginFineState();
      }

      print("socialToken is not null: ${_socialToken != null}");
    }

    else if(event is GoogleLoginResetEvent){
      yield GoogleLoginFineState();
    }
  }
}

/*
class LoginBlocs{
  final GoogleLoginBloc googleLoginBloc = GoogleLoginBloc();
  final FacebookLoginBloc facebookLoginBloc = FacebookLoginBloc();

  static final LoginBlocs _singleton = new LoginBlocs._internal();
  factory LoginBlocs() {
    return _singleton;
  }
  LoginBlocs._internal();

  void reset(){
    googleLoginBloc.reset();
    facebookLoginBloc.reset();
  }


}
*/

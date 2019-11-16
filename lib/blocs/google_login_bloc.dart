import 'package:dusza2019/other/database.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bloc/bloc.dart';

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

class GoogleUpdateAccessToken extends GoogleLoginEvent {
  @override String toString() => 'GoogleUpdateAccessToken';
  @override
  List<Object> get props => null;
}

class GoogleLoginResetEvent extends GoogleLoginEvent {
  @override String toString() => 'GoogleLoginResetEvent';
  @override
  List<Object> get props => null;
}

class GoogleReadyToLoginState extends GoogleLoginState {
  @override String toString() => 'GoogleReadyToLoginState';
  @override
  List<Object> get props => null;
}

class GoogleLoginSuccessfulState extends GoogleLoginState {
  final String email;
  final String accessToken;

  GoogleLoginSuccessfulState(this.email, this.accessToken);

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

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {

  GoogleSignIn _googleSignIn;
  FirebaseAuth _auth;

  GoogleLoginBloc(){
    _googleSignIn = GoogleSignIn(scopes: [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/userinfo.profile",
      "openid",
      "https://www.googleapis.com/auth/drive.appdata"
    ]);
    _auth = FirebaseAuth.instance;
  }

  GoogleLoginState get initialState => GoogleReadyToLoginState();

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
    if (event is GoogleLoginButtonPressedEvent || event is GoogleUpdateAccessToken) {
      yield GoogleLoginWaitingState();

      try{
        print("google login: 1");
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

        print("google login: 2");

        if(googleUser == null) {
          print("Auth failed!!!");
          yield GoogleReadyToLoginState();
        }else{
          print("google login: 3");
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

          print("google login: 4");
          final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          print("google login: 5");

          final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
          print("signed in " + user.displayName);

          final accessToken = googleAuth.accessToken;
          yield GoogleLoginSuccessfulState(googleUser.email, accessToken);
        }
      }catch(exception, stacktrace){
        Crashlytics().recordError(exception, stacktrace);
        yield GoogleReadyToLoginState();
      }
    }

    else if(event is GoogleLoginResetEvent){
      logout();
      yield GoogleReadyToLoginState();
    }
  }
}


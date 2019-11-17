import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GoogleLoginEvent extends Equatable {
  GoogleLoginEvent([List props = const []]) : super(props);
}

abstract class GoogleLoginState extends Equatable {
  GoogleLoginState([List props = const []]) : super(props);
}

class GoogleCheckAlreadyLoggedIn extends GoogleLoginEvent {
  @override
  String toString() => 'GoogleCheckAlreadyLoggedIn';
}

class GoogleLoginButtonPressedEvent extends GoogleLoginEvent {
  @override
  String toString() => 'GoogleLoginButtonPressed';
}

class GoogleUpdateAccessToken extends GoogleLoginEvent {
  @override
  String toString() => 'GoogleUpdateAccessToken';
}

class GoogleLoginResetEvent extends GoogleLoginEvent {
  @override
  String toString() => 'GoogleLoginResetEvent';
}

class GoogleReadyToLoginState extends GoogleLoginState {
  @override
  String toString() => 'GoogleReadyToLoginState';
}

class GoogleLoginSuccessfulState extends GoogleLoginState {
  final String email;
  final String accessToken;
  final Map<String, String> headers;

  GoogleLoginSuccessfulState(this.email, this.accessToken, this.headers);

  @override
  String toString() => 'GoogleLoginSuccessfulState';
}

class GoogleLoginWaitingState extends GoogleLoginState {
  @override
  String toString() => 'GoogleLoginWaitingState';
}

class GoogleLoginFailedState extends GoogleLoginState {
  GoogleLoginFailedState() : super([]);

  @override
  String toString() => 'GoogleLoginFailedState';
}

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  GoogleSignIn _googleSignIn;
  FirebaseAuth _auth;

  GoogleLoginBloc() {
    _googleSignIn = GoogleSignIn(scopes: [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/userinfo.profile",
      "openid",
      "https://www.googleapis.com/auth/drive.appdata",
      "https://www.googleapis.com/auth/drive.file"
    ]);
    _auth = FirebaseAuth.instance;
  }

  GoogleLoginState get initialState => GoogleReadyToLoginState();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void reset() {
    this.dispatch(GoogleLoginResetEvent());
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Stream<GoogleLoginState> mapEventToState(GoogleLoginEvent event) async* {
    switch (event.runtimeType) {
      case GoogleLoginButtonPressedEvent:
      case GoogleUpdateAccessToken:
        yield GoogleLoginWaitingState();

        try {
          print("google login: 1");
          final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

          print("google login: 2");

          if (googleUser == null) {
            print("Auth failed!!!");
            yield GoogleReadyToLoginState();
          } else {
            print("google login: 3");
            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;

            print("google login: 4");
            final AuthCredential credential = GoogleAuthProvider.getCredential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            print("google login: 5");

            final FirebaseUser user =
                (await _auth.signInWithCredential(credential)).user;
            print("signed in " + user.displayName);

            final accessToken = googleAuth.accessToken;
            yield GoogleLoginSuccessfulState(
                googleUser.email, accessToken, await googleUser.authHeaders);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("GoogleEnabled", true);
          }
        } catch (exception, stacktrace) {
          Crashlytics().recordError(exception, stacktrace);
          yield GoogleReadyToLoginState();
        }

        break;
      case GoogleLoginResetEvent:
        logout();
        yield GoogleReadyToLoginState();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("GoogleEnabled", false);

        break;
      case GoogleCheckAlreadyLoggedIn:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool flag = prefs.getBool("GoogleEnabled");
        if (flag) {
          this.dispatch(GoogleUpdateAccessToken());
        }

        break;
      default:
        break;
    }
  }
}

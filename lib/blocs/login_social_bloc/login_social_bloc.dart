
import 'package:faiikan/blocs/login_social_bloc/login_social_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSocialBloc extends Bloc<LoginSocialEvent, LoginSocialState> {
  LoginSocialBloc() : super(LoginSocialInitial());
  @override
  Stream<LoginSocialState> mapEventToState(LoginSocialEvent event) async* {
    yield LoginSocialLoading();
    //google
    if (event is LoggedInGoogle) {
      final googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
          'profile',
          'https://www.googleapis.com/auth/contacts.readonly'
        ],
      );
      try {
        await googleSignIn.signIn();


          yield LoginSocialSuccess();

      } catch (e) {
        yield LoginSocialFailure(e.toString());
      }
      //facebook
    } else if (event is LoggedInFacebook) {
//      final facebookSignIn = FacebookLogin();
//      try {
//        final FacebookLoginResult facebookLogin =
//            await facebookSignIn.logIn(['email']);
//
//        print("token: " + facebookLogin.accessToken.token);
//        switch (facebookLogin.status) {
//          case FacebookLoginStatus.loggedIn:
//              yield LoginSocialSuccess();
//            break;
//          case FacebookLoginStatus.cancelledByUser:
//            yield LoginSocialCancelled(textCancel: 'Cancelled');
//            break;
//          case FacebookLoginStatus.error:
//            yield LoginSocialFailure(facebookLogin.errorMessage);
//            break;
//        }
//      } catch (e) {
//        yield LoginSocialFailure(e.toString());
//      }
      //apple
    }
  }
}

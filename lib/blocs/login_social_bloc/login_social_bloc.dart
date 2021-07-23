
import 'package:faiikan/blocs/login_social_bloc/login_social_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

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
      final facebookSignIn = FacebookLogin();
      try {
        final FacebookLoginResult facebookLogin =
            await facebookSignIn.logIn();
        yield LoginSocialSuccess();

      } catch (e) {
        yield LoginSocialFailure(e.toString());
      }
      //apple
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _google = new GoogleSignIn();

  Future<String> siginWithGoogle() async {
    final GoogleSignInAccount googleAccount = await _google.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = await authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;

      assert(user.uid == currentUser.uid);

      return "$user";
    }

    return null;
  }
}

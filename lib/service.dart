import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();

String name = "";
String email = "";
String imageUrl = "";

Future signOutWithGoogle() async {
  GoogleSignIn().signOut();
}

Future<String> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

  final User? user = authResult.user;

  if (user != null) {
    assert(user.email != null);
    assert(user.photoURL != null);
    assert(user.displayName != null);
    name = user.displayName!;
    imageUrl = user.photoURL!;
  }

  // Once signed in, return the UserCredential
  return "";
}

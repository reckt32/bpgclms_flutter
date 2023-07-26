import 'package:academy_app/screens/courses_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;

//   GoogleSignInAccount get user => _user!;
//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     _user = googleUser;
//     final googleAuth = await googleUser?.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     await FirebaseAuth.instance.signInWithCredential(credential);
//     notifyListeners();
//   }
// }
class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> googleLogin(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();
    _user = googleUser;

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      String email = googleUser.email;
      String userId = googleUser.id;

      Navigator.pushNamedAndRemoveUntil(
        context,
        CoursesScreen.routeName,
        (r) => false,
        arguments: {'email': email, 'userId': userId},
      );

      notifyListeners();
    }
  }
}

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/user_model.dart';
import 'package:cookmaster_front/app/data/repositories/user_repository.dart';
import 'package:cookmaster_front/app/data/services/auth_exception.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? users;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      users = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      final UserStore store = UserStore(
        repository: UserRepository(
          client: HttpClient(),
        ),
      );

      if (firebaseUser!.email != null) {
        await store.getUser(firebaseUser.email);
        final UserModel userModel = store.state.value;
        if (userModel.id == 0) {
          store.postUser(firebaseUser);
        }
      }

      return users = firebaseUser;
    } on FirebaseAuthException catch (e) {
      throw AuthException('Error: ${e.message}');
    }
  }

  logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      users = null;

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw AuthException('Error: ${e.message}');
    }
  }
}

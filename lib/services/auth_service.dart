import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //get current user
  // User? getCurrentUser() {
  //   return _firebaseAuth.currentUser;
  // }

  //sign in with email and password
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    //catch errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up with email and password
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    //catch errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign ouut

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  AuthService(this._firebaseAuth);
  Future<String?> signIn({required String phoneNumber}) async {
    try {
      await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  // Future<String?> signUp({required String phoneNumber}) async {
  //   try {
  //     await _firebaseAuth.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}

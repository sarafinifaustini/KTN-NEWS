
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final _auth = FirebaseAuth.instance;


  Future<UserCredential> signInWithCredential(AuthCredential credential) {
    // var user = await _firebaseAuth.currentUser();
    // await _populateCurrentUser(user);
    return _auth.signInWithCredential(credential);
  }
  Future<void> logout() => _auth.signOut();
  Stream<User?> get currentUser {
    return _auth.authStateChanges();
  }




}
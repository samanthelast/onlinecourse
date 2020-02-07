
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_courses/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_courses/services/database.dart';

import 'MyProxy.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
   
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }


Future<bool> loginWithGoogle() async {
 
    try {
      
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if(account == null )
        return false;
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      FirebaseUser user = res.user;

        //auto create collection first time
        await DatabaseService(uid: user.uid).updateUserData(0);

        //

      if(res.user == null)
        return false;
      return true;
    } catch (e) {
      print("Error logging with google");
      return false;
    }
  }


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
   
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;


      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      
        //auto create collection first time
        await DatabaseService(uid: user.uid).updateUserData(0);

        //
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
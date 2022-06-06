import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/chat_App/model/User.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users? _userfromFirebaseUser(User user){
    return user != null ? Users(userId: user.uid): null;
  }
  Future signInEmailAndPassword(String email,String password) async{
    try{
      final UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user!;
      return _userfromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }
  }

  Future signUpwithEmailAndPassword(String email, String password) async{
    try{
      final UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user!;
      return _userfromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }
  }

  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e);
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e);
    }
  }

}
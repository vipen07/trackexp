import 'package:trackexp/Model/MyUser.dart';
import 'package:trackexp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackexp/Model/money.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based on firebase user
   _userFromFirebaseUser(User? user){
    return user!=null ? MyUser(uid:user.uid):null;
  }
                      //name of the stream
  Stream<MyUser?> get user{
                  //gives us firebaseUser mapping to our user
     return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }
  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result=await _auth.signInAnonymously();
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //register with email and password
  Future registerWithEmailAndPassword(String email,String pass) async{
     try{
       UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
       User? user=result.user;
       //create a new document for the user with the uid
       await DatabaseService(uid: user!.uid).SetUserData('Transportation','for travel','100','Expense',DateTime(2017, 9, 7, 17, 30));

       return _userFromFirebaseUser(user);
     }
     catch(e){
       print(e.toString());
       return null;
     }
  }
  //sign in with email and pass
  Future signInWithEmailAndPassword(String email,String pass) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async{
     try{
       return await _auth.signOut();
     }
     catch(e){
        print(e.toString());
        return null;
     }
  }
}
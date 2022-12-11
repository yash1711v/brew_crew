import 'package:brew/Screens/Aunthentication/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../module/module.dart';

//---------------------------------------------------------------------------------2/12/2022----------------------------------------------------------------------------------------------------------
//This is Basically For Connecting with Firebase
class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;//creating instance of firebaseAuthentication Class  //creating user(user class Vala) object based on firebaseUser

  //----------------------------------------------------done on 6/12/2022-----------------------------------------------------------------------------------------------------------------------------
  user? _userFromFirebaseuser(User u)// this is Our Method Returning the user Object Where we are accepting  the Firebase user
  {
    if (u!=null) {
      return user(uid: u.uid); //here u is firebaseUser object and user is user class's constructor
    } else {
      return null;
    }
  }
  //---------------------------done on 6/12/2022(copy se jarur padhe )------------------------------------------------------------------------------------------------------------------------------
  //auth chane user stream
  Stream<user?> get usr{//useing the stream which is returning the userclass stream not of firebaseuser
    return _auth.authStateChanges().map((User? ur)=>_userFromFirebaseuser(ur!));
    //.map(_userFromFirebaseUser)
  }
  //sign in anon(2/12/2022)
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously(); //AuthResult is Changed To User UserCredential?
      User? user = result.user;//this is For firebase for ging user to Above  method
      return _userFromFirebaseuser(user!);//returning above method which is showing returning the user object
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in with email & password
Future signinWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? Fuser = result.user;// puting the Current  Firebase user to the Custom user Class
      return _userFromFirebaseuser(Fuser!);
    }catch(e){
      print(e.toString());// if try is not true we are cathing the error
      return null;
    }
}
  //register with email & password
  Future registerWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);//using a method of firebase Authentication which is createUSerwithEmailAndPassword
    User? Fuser = result.user;// puting the Current  Firebase user to the Custom user Class
      return _userFromFirebaseuser(Fuser!);//Returning the user With it uid if all the try is true
    }catch(e){
        print(e.toString());// if try is not true we are cathing the error
      return null;
    }
  }

  //Sign out
Future signout() async{
    try{
      return await _auth.signOut();//signout method of Firebase Auth
    }catch(e){
      print(e.toString());
    }
}

}

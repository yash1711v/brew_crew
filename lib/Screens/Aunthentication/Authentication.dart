import 'package:brew/Screens/Aunthentication/registeration.dart';
import 'package:brew/Screens/Aunthentication/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//---------------------------------------------------------------------------------2/12/20222----------------------------------------------------------------------------------------------------------
//Stores All the Authenticated Data in tit And it is StateFull Widget As it is Changin its State
class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    bool ShowSignin=true;
    void toggleView()//this Function is toggle between one to Another
    {
      setState(() {
        ShowSignin=!ShowSignin;//this Simple Reverse the Value What so ever is in the showSignin
      });
    }
   if(ShowSignin==true)
     {
       return signin(toggleView: toggleView);//passing the name parameter of Toggle which can be accesed by them in there Widget
        /*
        * here the Text before : can be anything but the TExt after this must be same as the Text Before it
        * */
     }
   else{
     return Registeration(toggleView: toggleView);//passing the name parameter of Toggle Whhich can be accesed by them in there Wodget
   }
  }
}

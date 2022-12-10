//-----------------------------------------------------------------------------------2/12/2022---------------------------------------------------------------------------------------------
//createa stateless Widget in it The Wrapper Class Is Basically Wrapping Up all the Things Inside it And Show what IS PRocessed Like Home Screen And Authentication
import 'package:brew/Screens/Aunthentication/Authentication.dart';
import 'package:brew/module/module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/Home.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
 Widget  build(BuildContext context) {
    //getting what to show based on user data cominng from provide
    final uuser=Provider.of<user?>(context);//Just Creating the variable and storing the value We are getting from the user class linked with Firebase User
    //print(uuser);//Just showing for test Purpose
    //return Either Home or Authentication widget
   if(uuser==null)
     {
       return Authentication();
     }
   else
     {
       return Home();
     }
  }
}

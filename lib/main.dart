
import 'package:brew/Screens/Aunthentication/Authentication.dart';
import 'package:brew/Screens/Aunthentication/signin.dart';
import 'package:brew/Screens/Wrapper/Wrapper.dart';
import 'package:brew/Services/auth.dart';
import 'package:brew/module/module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Aunthentication/registeration.dart';
import 'Screens/Home/Home.dart';
//---------------------------------------------------------------------------2/12/2022-----------------------------------------------------------------------------------------------------------------
/*create a Folder int the Lib Called Screens Which Saves All the Screens OF Us
  Create a Sub Folders OF OUr App Screen Like
  Home which Stores all the Home Screen data Means a Home Screen Dart File
  Authentication Which Stores all the authentication Data Means a Authentication Screen Dart File
 */
Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Authentication auth=Authentication();
  await Firebase.initializeApp();
  runApp(
      StreamProvider .value(
        catchError: (_, __) => null,//applying this to avoiding the error To fix StreamProvider<MyUser?>, but no `catchError` was provided:
      value : AuthServices().usr,//creating AuthenticaionServices and Access the user Stream on it
    initialData: null,
    child: MaterialApp(
      routes: {"/registeration":(context)=>Registeration(),
        "/sigin":(context)=>signin(),
        "/Home":(context)=>Home(),

      },//as the Video method is not Working for me
//Our app Goes From Main To Wrapper From wrapper it Goes To Either Authentication or a Home
    home: Wrapper(),

),
  ),

  );
}
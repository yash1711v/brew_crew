import 'package:brew/Screens/Aunthentication/Authentication.dart';
import 'package:brew/Screens/Home/Home.dart';
import 'package:brew/Screens/Wrapper/Wrapper.dart';
import 'package:brew/Services/auth.dart';
import 'package:brew/Shared/LoadingScren.dart';
import 'package:brew/module/module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Services/database.dartt.dart';
class Registeration extends StatefulWidget {
  // late final Function toggleView;//making a variable of Function type to accept the value
  // Registeration({required this.toggleView});//constructor which is Recieving the value and asign it to the Registeration's toggleView
  @override
  State<Registeration> createState() => _RegisterationState();
}
class _RegisterationState extends State<Registeration> {

  final AuthServices _auth=AuthServices();//making object of Authservices
  final _formkey=GlobalKey<FormState>();//Making the Globalkey of FormState type to identify and to keep check on our form now declare this in below in formkey
  CollectionReference ref = FirebaseFirestore.instance.collection('brews');
  User? us=FirebaseAuth.instance.currentUser;
  bool loading=false;
  String email="";
  String Password="";
  final List<String> sugars =['0','1','2','3','4'];
  late String _currentName;
  late String _currentSugar;
  int _currentStrength=100;
  /*11/12/2022*/ String Error= " ";
   @override
   void initState() {
     setuoEmail();
     super.initState();
     print("objext");

   }
   setuoEmail(){
     email="abc.gmail.com";
   }
   @override
  Widget build(BuildContext context) {
     print("build Method Called");
    return loading?Loading():Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title:Text('Register  to brew Crew'),
        backgroundColor: Colors.brown[800],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(onPressed: (){
            Navigator.pop(context, "/sigin");
            //widget.toggleView();//now we are Using widget not Widget and This cause this.toggle will Going to refer the state change Toogle but we want this widgets Toogle
          },
            icon: Icon(Icons.person_add,color: Colors.white,),
            label: Text("Signin",style: TextStyle(
              color: Colors.white,
            ),
            ),
          )
        ],
      ), body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),//to make Padding from top and bottom equally
        child: Form(
          key:_formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: "",
                decoration: InputDecoration(
                  hintText: "Change name",
                  labelText: "Update Your name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Colors.brown),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'Please enter name' : null,
                onChanged: (val) =>
                    setState(() {
                      _currentName = val;
                    }),
              ),
              SizedBox(height: 20.0,),
              //DropDown
              DropdownButtonFormField(
                value: "0",
                //Setting up the Value Which is Updated
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Colors.brown),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black,),
                  hintText: "Sugar Value",
                ),
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                      value: sugar,
                      child: Text(
                          '$sugar sugars') //$means Calling the $ means That we are Calling the Abover Sugar Value,
                  );
                }).toList(),
                onChanged: (val) =>
                    setState(() {
                      _currentSugar = val!;
                    }),
              ),
              //slidebar
              SizedBox(height: 20.0,),
              Slider(
                min: 100,
                max: 900,
                divisions: 8,
                value: (_currentStrength).toDouble(),
                activeColor: Colors.brown[_currentStrength],
                //to make the slider ColorFull
                inactiveColor: Colors.brown[_currentStrength],
                onChanged: (double value) {
                  setState(() {
                    _currentStrength = value.round();
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  labelText: "Enter Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Colors.brown),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                validator: (val)=>val!.isEmpty?'Enter and email': null,//checking wheter the email address field is empty or not if yes the print helper String if nor return null
                onChanged: (val){
                  setState(() {
                    email=val;// seting the email state from empty to the val which is given to the textfield
                  });
                },//onchange mtlb agar kuch bhi type karte hai ya kuch bhi delete karte hai toh vo nai value aegi
              ),
              SizedBox(height: 20.0,),
              TextFormField(  decoration: InputDecoration(
                hintText: "Enter Password",
                labelText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Colors.brown),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
                obscureText: true, // to hide the Letters
                validator: (val)=>val!.length<8?'Enter a Password 8 or 8+ chars long':null,//checking wheter the password is 8 character long or not
                onChanged: (val){
                  setState(() {
                    Password=val;//puting value of password to the String TYpe of password
                  });
                },
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(

                onPressed: () async {
                  if(_formkey.currentState!.validate()){//checking the current  state of Form
                    setState((){loading=true;});
                    dynamic result=await _auth.registerWithEmailAndPassword(email, Password);
                    if(result==null)
                    {
                      setState(() {
                        Error= _auth.registerWithEmailAndPassword(email, Password).onError((error, stackTrace) => print(error))as String;
                        loading=false;
                      });

                    }

                    else{
                      _auth.registerWithEmailAndPassword(email, Password).whenComplete(() {
                        Navigator.pop(context, "/Home");

                      });
                      Fluttertoast.showToast(
                          msg: "Registeration SuccessFull",
                          backgroundColor: Colors.grey);
                    }
                  ref.doc(_auth.Uid).update({
                    "name" : _currentName,
                    "sugars" : _currentSugar,
                    "strength" : _currentStrength,
                  });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.brown[300];
                    }
                    else if (states.contains(MaterialState.hovered)) {
                      return Colors.brown[800];
                    }
                    else {
                      return Colors.brown[500];
                    }
                  }),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height:12.0),
              Text( // to display the error
                Error,
                style: TextStyle(color: Colors.red,fontSize: 14),
              )
            ],
          ),
        ),
    ),
      ),
    );
  }
}
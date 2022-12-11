import 'package:brew/Screens/Aunthentication/Authentication.dart';
import 'package:brew/Screens/Home/Home.dart';
import 'package:brew/Screens/Wrapper/Wrapper.dart';
import 'package:brew/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Registeration extends StatefulWidget {
  // late final Function toggleView;//making a variable of Function type to accept the value
  // Registeration({required this.toggleView});//constructor which is Recieving the value and asign it to the Registeration's toggleView
  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final AuthServices _auth=AuthServices();//making object of Authservices
  final _formkey=GlobalKey<FormState>();//Making the Globalkey of FormState type to identify and to keep check on our form now declare this in below in formkey
  String email="";
  String Password="";
  /*11/12/2022*/ String Error= " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
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
    ), body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),//to make Padding from top and bottom equally
      child: Form(
        key:_formkey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                  hintText: "Email  Id",
                  labelText: "Enter Your Email id"
              ),
              validator: (val)=>val!.isEmpty?'Enter and email': null,//checking wheter the email address field is empty or not if yes the print helper String if nor return null
              onChanged: (val){
                setState(() {
                  email=val;// seting the email state from empty to the val which is given to the textfield
                });
              },//onchange mtlb agar kuch bhi type karte hai ya kuch bhi delete karte hai toh vo nai value aegi
            ),
            SizedBox(height: 20.0,),
            TextFormField( decoration: InputDecoration(
                hintText: "Passwrord",
                labelText: "Enter Your Password"
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
                  dynamic result=await _auth.registerWithEmailAndPassword(email, Password);
                  if(result==null)
                    {
                        setState(() {
                          Error= _auth.registerWithEmailAndPassword(email, Password).onError((error, stackTrace) => print(error))as String;
                      });

                    }

                  else{
                          _auth.registerWithEmailAndPassword(email, Password).whenComplete(() {
                            Navigator.pop(context, "/Home");

                          });
                          Fluttertoast.showToast(
                              msg: "login SuccessFull",
                              backgroundColor: Colors.grey);
                  }
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
    );
  }
}

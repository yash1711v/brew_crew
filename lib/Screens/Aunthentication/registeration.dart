import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Registeration extends StatefulWidget {
  late final Function toggleView;//making a variable of Function type to accept the value
  Registeration({required this.toggleView});//constructor which is Recieving the value and asign it to the Registeration's toggleView
  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  String email="";
  String Password="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
        title:Text('Register  to brew Crew'),
    backgroundColor: Colors.brown[800],
    elevation: 0.0,
    ), body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),//to make Padding from top and bottom equally
      child: Form(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                  hintText: "Email  Id",
                  labelText: "Enter Your Email id"
              ),
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
              obscureText: true,// to hide the Letters
              onChanged: (val){
                setState(() {
                  Password=val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: (){
                Fluttertoast.showToast(
                  msg: email,
                  backgroundColor: Colors.grey,
                );

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
          ],
        ),
      ),
    ),
    );
  }
}

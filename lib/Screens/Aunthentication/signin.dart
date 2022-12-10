import 'package:brew/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Home/Home.dart';
//-----------------------------------------------------------------------------------4/12/20022----------------------------------------------------------------------------------------------------------
class signin extends StatefulWidget {

//making of constructor to accept the the Togglemethod
  late final Function toggleView;//making a variable of Function type to accept the value
  signin({required this.toggleView});//constructor which is Recieving the value and asign it to the signin's toggleView
  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final AuthServices _auth= AuthServices();
  //6/12/2022
  late String email="";
  late String Password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title:Text('Signin to brew Crew'),
        backgroundColor: Colors.brown[800],
        elevation: 0.0,
        actions: <Widget>[
           TextButton.icon(onPressed: (){

           },
           icon: Icon(Icons.person_add,color: Colors.white,),
             label: Text("Register",style: TextStyle(
               color: Colors.white,
             ),),
           )
        ],
      ),
//---------------------------------------------------------------------------4/12/2022-----------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------This is For Just practice purpose original is down below-------------------------------------------------------------------------------
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding:EdgeInsets.symmetric(vertical: 20,horizontal: 50) , //Horizontal or vertically equl padding rahe oske Liye hai Ye
                 // child: ElevatedButton(
                 //   onPressed: () async{
                 //    dynamic result= await _auth.signInAnon();
                 //    // if(result==null)
                 //    //   {
                 //    //     print("Error");
                 //    //   }
                 //    // else{
                 //    //  // print("signin");
                 //    //   //print(result);
                 //    //   //just now print the userid Uid instead of whole result
                 //    //   //print(result.uid);
                 //    //
                 //    // }
                 //   },
                 //   style: ButtonStyle(
                 //     backgroundColor: MaterialStateProperty.resolveWith((states){
                 //     if(states.contains(MaterialState.pressed))
                 //     {
                 //       return Colors.brown[300];
                 //        }
                 //     else if(states.contains(MaterialState.hovered)){
                 //       return Colors.brown[800];
                 //        }
                 //     else{
                 //       return Colors.brown[500];
                 //     }
                 //     }
                 //      ),
                 //   ),
                 //   child: Text('Signin in Anon'),
                 // ),
//----------------------------------------------------------------------------------9/12/2022---------------------------------------------------------------------------------------------------------
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),//to make Padding from top and bottom equally
                child: Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            hintText: "Email  Id",
                          labelText: "Enter Your Email id",
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
                          'Sigin in',
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
}}

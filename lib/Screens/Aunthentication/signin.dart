import 'package:brew/Services/auth.dart';
import 'package:brew/Shared/LoadingScren.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Home/Home.dart';
//-----------------------------------------------------------------------------------4/12/20022----------------------------------------------------------------------------------------------------------
class signin extends StatefulWidget {

//making of constructor to accept the the Togglemethod
//   late final Function toggleView;//making a variable of Function type to accept the value
//   signin({required this.toggleView});//constructor which is Recieving the value and asign it to the signin's toggleView

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final AuthServices _auth= AuthServices();
  final _formkey=GlobalKey<FormState>();
  //creating the boolean type for loading initially it is False
  bool loading=false;
  //6/12/2022
  late String email="";
  late String Password;
  void initState() {
    setuoEmail();
    super.initState();
    print("object");

  }
  setuoEmail(){
    email="abc.gmail.com";
  }
  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(//checking whether the Loading is false or not if it is false Show Scafold And if not Show Loading screem
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title:Text('Signin to brew Crew'),
        backgroundColor: Colors.brown[800],
        elevation: 0.0,
        actions: <Widget>[
           TextButton.icon(onPressed: (){
          //widget.toggleView();
             //Navigator.pop(context, "/registeration");
          Navigator.pushNamed(context, "/registeration");//now we are Using widget not Widget and This cause this.toggle will Going to refer the state change Toogle but we want this widgets Toogle
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
                  key:_formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            hintText: "Enter Email",
                          labelText: "Enter Email",
                        ),
                        initialValue: email,
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
                          onPressed: () async{
                            // dynamic result=await _auth.signInAnon();
                            // if(result==null)
                            // {
                            //   print("Error");
                            // }
                            // else{
                            //   // print("signin");
                            //   // print(result);
                            //   // //just now print the userid Uid instead of whole result
                            //   // print(result.uid);
                            if(_formkey.currentState!.validate()){//checking the current  state of Form
                              setState(() {
                                loading=true;//true when Button is Clicked and Every thing is valid
                              });//to change the state and to hide all the scafold stuff and Just to Show the Loading screen
                            dynamic result=await _auth.signinWithEmailAndPassword(email, Password);
                            if(result==null)
                            {
                                setState(() {
                                 _auth.signinWithEmailAndPassword(email, Password).onError((error, stackTrace) => print(error))as String;
                                 loading=false;
                                });

                              }
                            else{   Fluttertoast.showToast(
                                msg: "login SuccessFull",
                                backgroundColor: Colors.grey);}
                            }
                            Fluttertoast.showToast(
                              msg: "logged in sucessFully",
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

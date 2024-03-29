import 'package:brew/Screens/Home/settingsForm.dart';
import 'package:brew/Services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; When We Are Uing Query SnapShot
import 'package:flutter/material.dart';
import 'package:brew/Services/database.dartt.dart';
import 'package:provider/provider.dart';
import 'package:brew/Screens/Home/brewlist.dart';

import '../../module/brew.dart';
//-----------------------------------------------------------------------------------2/12/2022--------------------------------------------------------------------------------------------------------
//It is containg two Things Either Brew List or settings Which is Means It is Just Updating There is No state Change So We Use State Full Widget
class Home extends StatelessWidget {
AuthServices _auth=AuthServices();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder( // <-- SEE HERE
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          enableDrag: true,
          backgroundColor: Colors.orangeAccent[100],
          builder: (context){
        return  Container(
          height: 450,
          padding: EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 10.0),
            child: SettingsForm());
      });
    }//to make the Bottom sheet
    return StreamProvider<List<brew>>.value(
      value : DatabaseServices(uid: _auth.Uid).brews,//creating DatabaseStream and Access the brew Stream on it
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.brown[800],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(onPressed: () async{
              await _auth.signout();
            },
                icon: Icon(Icons.logout,color: Colors.white,),
                label: Text('Logout',
                style: TextStyle(
                  color: Colors.white
                ),),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assists/coffee-beans-on-a-table.jpg'),
              fit: BoxFit.cover
            )
          ),
            child: BrewList()
        ),
        floatingActionButton: SizedBox(
          height: 50,
          width: 150,
          child: FloatingActionButton(
            onPressed: () { _showSettingsPanel(); },
            child: Text('UPDATE'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))
            ),
            backgroundColor: Colors.brown[800],
          ),
        ),
      ),

    );
  }
}




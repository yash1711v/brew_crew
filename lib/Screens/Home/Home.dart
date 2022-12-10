import 'package:brew/Services/auth.dart';
import 'package:flutter/material.dart';
//-----------------------------------------------------------------------------------2/12/2022--------------------------------------------------------------------------------------------------------
//It is containg two Things Either Brew List or settings Which is Means It is Just Updating There is No state Change So We Use State Full Widget
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
final AuthServices _as=new AuthServices();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.brown[800],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(onPressed: () async{
            await _as.signout();
          },
              icon: Icon(Icons.logout,color: Colors.white,),
              label: Text('Logout',
              style: TextStyle(
                color: Colors.white
              ),),
          )
        ],
      ),
    );
  }
}


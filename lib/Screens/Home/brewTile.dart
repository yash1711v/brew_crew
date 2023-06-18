import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew/module/brew.dart';

import '../../Services/auth.dart';
class BrewTile extends StatelessWidget {
  late final brew Brew;
  CollectionReference ref = FirebaseFirestore.instance.collection('brews');
  //AuthServices _auth=AuthServices();
  BrewTile({required this.Brew});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 8.0 ),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[Brew.strength],
          ),
          title: Text(Brew.name),
          subtitle: Text('Takes ${Brew.sugar} sugar(s)'),
        ),
      ),
    );
  }
}

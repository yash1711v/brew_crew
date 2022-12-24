//responsible for outputting different brews on the page or cycling to them
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import '../../module/brew.dart';
import 'brewTile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews=Provider.of<List<brew>>(context)??[];//Cycle the brews and just Put them Out
   // print(brews.docs);
   //  for(var doc in brews.docs)
   //    {
   //      print(doc.data());
   //    } used when we are printing from firestore By Query snap shot here now we have our Own <odel Class so We just delete this
    // just use for each loop to go through the list and print
    // brews.forEach((brew) {
    //     print(brew.name);
    //   print(brew.sugar);
    //   print(brew.strength);
    //   });
    return ListView.builder(
        itemCount: brews.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return BrewTile(Brew: brews[index],);
      },
    );
  }
}

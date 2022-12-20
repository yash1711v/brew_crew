//12/12/2022
import 'package:cloud_firestore/cloud_firestore.dart';

import '../module/brew.dart';
class DatabaseServices{
   final String uid;
  DatabaseServices({required this.uid});
  //here we Have A Different Properties to interact with  Firestore database
  //Collection reference  (it is A reference to A particular Collection in our Firestore Database)
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  Future updateuserData(String sugars,String name,int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }//used twice when we signin up and when we are going to update the data
   //brew list from snapshot
   List<brew> _brewListFromsnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return brew(
          name: doc.get('name')??'',
          sugar: doc.get('sugars')??'0',
          strength: doc.get('strength')??0
      );}
    ).toList();}
//get brews Stream
//   Stream<QuerySnapshot> get brews{
//       return brewCollection.snapshots();
//     }
    //geting the Stream which is of type List<brew>
  Stream<List<brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromsnapshot);
  }
}
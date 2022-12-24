//12/12/2022
import 'package:cloud_firestore/cloud_firestore.dart';

import '../module/brew.dart';
import '../module/module.dart';
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
          strength: doc.get('strength')//yaha Value denge toh ruk jaegs
      );}
    ).toList();}
//get brews Stream This from Firebase to Our user
//   Stream<QuerySnapshot> get brews{
//       return brewCollection.snapshots();
//     }
    //geting the Stream which is of type List<brew>
  Stream<List<brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromsnapshot);
  }
  //userData For SnapShot
  UserData _UserdataFromSnapshot(DocumentSnapshot snapshot){ //Calling the User Data Class of Module
    return UserData(uid: uid, name: snapshot.get('name'), Sugar: snapshot.get('sugars'), Strength: snapshot.get('Strength'));
  }
  //This Stream is to give Or update or Travel The data From User To the
    Stream<UserData> get userDate{
    return brewCollection.doc(uid).snapshots().map(_UserdataFromSnapshot);
    }
}
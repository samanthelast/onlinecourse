import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  Future updateUserData(String likedVideo)async{


  }

}
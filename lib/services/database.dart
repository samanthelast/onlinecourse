import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  Future updateUserData(int credit)async{
    return await userCollection.document(uid).setData({
      'credit' : credit,
    });

  }

}
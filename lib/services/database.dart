import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  
  final CollectionReference userCollection = Firestore.instance.collection('users');
Future BuyVideo(List<dynamic> course_id)async{
    return await userCollection.document(uid).updateData({
      'bought_videos' : FieldValue.arrayUnion(course_id),
    });

  }
Future AddDepositToUser(int amount)async{
    return await userCollection.document(uid).updateData({
      'credit' : amount,
      
    });

  }


  Future updateUserData(int credit,List<dynamic> liked_videos,List<dynamic> bought_videos)async{
    return await userCollection.document(uid).setData({
      'credit' : credit,
      'liked_videos' : liked_videos,
      'bought_videos' : bought_videos,
    });

  }
  Future LikeVideo(List<dynamic> course_id)async{
    return await userCollection.document(uid).updateData({
      'liked_videos' : FieldValue.arrayUnion(course_id),
    });

  }
  Future UnLikeVideo(List<dynamic> course_id)async{
    return await userCollection.document(uid).updateData({
      'liked_videos' : FieldValue.arrayRemove(course_id),
    });
    
   

   



}}
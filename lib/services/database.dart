import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  Future updateUserData(int credit,List<dynamic> liked_videos)async{
    return await userCollection.document(uid).setData({
      'credit' : credit,
      'liked_videos' : liked_videos,
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
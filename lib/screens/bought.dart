import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/services/auth.dart';
import 'package:online_courses/widgets/horizontal_big_card.dart';

class Bought extends StatefulWidget {
  @override
  _BoughtState createState() => _BoughtState();
}

class _BoughtState extends State<Bought> {


  final AuthService _auth = AuthService();

  String _userID;
  List<dynamic> liked_videos;

  _getUserAuthEmail() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {

        _userID = user.uid;
      
      });

    } catch (error) {
      print(error.toString());
      return 'failed';
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserAuthEmail();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(centerTitle: true,title: Text('خریداری شده ها'),),
      body: StreamBuilder(
                      stream: Firestore.instance
                          .collection('users')
                          .document(_userID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var res = snapshot.data;
                        liked_videos = res['bought_videos'];
                         print(liked_videos.toString());
                        //return new Text(userDocument['credit'].toString());
                        return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('menu').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:

            return Container(
              padding: EdgeInsets.only(top: 32,right:16,left:16),
                child: ListView(
                  
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                   
                
//return Text(document.documentID.toString());
if(liked_videos.contains(document.documentID) ){
return Horizontal_big_card(docID:document.documentID ,title: document['title'],creator: document['creator'],banner:document['banner']);

}else{return Text('');}


              }).toList(),
            ));
        }
      },
    );
                
                      }),
    );
  }
}

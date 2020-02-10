import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/services/auth.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {


  final AuthService _auth = AuthService();

  String _userID;

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
      appBar: AppBar(centerTitle: true,title: Text('محبوب های من'),),
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
                         List<dynamic> videos = res['liked_videos'];
                         print(videos.toString());
                        //return new Text(userDocument['credit'].toString());
                        return Directionality(
                          child: ListTile(
                           
                            title: Text(videos.toString()),
                            
                            onTap: () {},
                          ),
                          textDirection: TextDirection.rtl,
                        );
                      }),
    );
  }
}
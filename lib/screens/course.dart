import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/models/user.dart';
import 'package:online_courses/services/database.dart';
import 'package:online_courses/widgets/buy_widget/buy_button.dart';

import 'package:online_courses/widgets/chewie_list_item.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class Course extends StatefulWidget {
  final String docID;
  const Course({this.docID});

  @override
  _CourseState createState() {
    return _CourseState();
  }
}

class _CourseState extends State<Course> {
  int isliked = 0;
  var _likeIcons = [Icons.favorite_border, Icons.favorite];
  String _userID;
  List<dynamic> liked_videos;
  _getUserID() async {
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
    _getUserID();
    //_getUserCredit();
  }

  _onChanged() {
    setState(() {
      List<dynamic> courseID = [widget.docID];

      //like bokon
      if (isliked == 0) {
        isliked = 1;
      } else {
        isliked = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("جزییات توتاریال"),
      ),
      body: Scaffold(
          body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance
                    .collection('menu')
                    .document(widget.docID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  var res = snapshot.data;
                  List<dynamic> videos = res['videos'];
                  //return new Text(userDocument['credit'].toString());
                  return Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(res['banner']),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 16,
                                          ),
                                          StreamBuilder(
                                              stream: Firestore.instance
                                                  .collection('users')
                                                  .document(_userID)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return new Text("Loading");
                                                }

                                                var userDocument =
                                                    snapshot.data;

                                               

                                                if (_userID != null) {
                                                  liked_videos = userDocument[
                                                      'liked_videos'];

                                                  if (liked_videos
                                                      .contains(widget.docID)) {
                                                    isliked = 1;
                                                  } else {
                                                    isliked = 0;
                                                  }
                                                }

                                                //return new Text(userDocument['credit'].toString());
                                                return IconButton(
                                                  color: Colors.red,
                                                  icon:
                                                      Icon(_likeIcons[isliked]),
                                                  onPressed: () async {
                                                    if (_userID != null) {
                                                      _onChanged();
                                                      List<dynamic> courseID = [
                                                        widget.docID
                                                      ];
                                                      //alredy liked or unliked?

                                                      liked_videos =
                                                          userDocument[
                                                              'liked_videos'];

                                                      //like bokon
                                                      if (liked_videos.contains(
                                                          widget.docID)) {
                                                        await DatabaseService(
                                                                uid: _userID)
                                                            .UnLikeVideo(
                                                                courseID);

                                                        print(liked_videos
                                                            .contains(
                                                                'unlike shod'));
                                                      } else {
                                                        //remove from like
                                                        await DatabaseService(
                                                                uid: _userID)
                                                            .LikeVideo(
                                                                courseID);
                                                        print(liked_videos
                                                            .contains(
                                                                'like shod'));
                                                      }
                                                    } else {
                                                      //boro to page login;
                                                      print(
                                                          "boro to login page");
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                          'ابتدا وارد حساب کاربری خود شوید',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ));
                                                    }
                                                  },
                                                );
                                              }),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                res['title'],
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                res['creator'],
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: <Widget>[
                                  BuyButton(res['price']),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text('تومان'),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(res['price'].toString()),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Icon(
                                            Icons.local_atm,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                res['description'],
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //height: (250.0 * videos.length),

                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: videos.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        Text(
                                          'ویدیو ' + (index + 1).toString(),
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        ChewieListItem(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                            videos[index],
                                          ),
                                          looping: false,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ],
        ),
      )),
    );
  }

  getFirebaseUser() async {
    await FirebaseAuth.instance.currentUser();
  }
}

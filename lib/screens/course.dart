import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/widgets/chewie_list_item.dart';
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
                        child:  Container(
                padding: EdgeInsets.only(left: 16,right: 16, top: 16, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      res['title'],
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      res['creator'],
                       textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 16,),
                    Row(children: <Widget>[
                      Expanded(flex:1,child: Row(children: <Widget>[ Container(
                                  alignment: Alignment.center,
                                  height: 32.0,
                                  width: 128,
                                  decoration: new BoxDecoration(

                                      color: Colors.blue,
                                      borderRadius:
                                          new BorderRadius.circular(9.0)),
                                  child: new Text("خرید توتاریال",
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white)))],)),
                      Expanded(flex:1,child: Row(mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[Text('تومان' ),
                      SizedBox(width: 8,),
                      Text(  res['price'].toString() ),
                      SizedBox(width: 16,),
                      Icon(
                              Icons.local_atm,
                              color: Colors.blue,
                            ),],)),
                      
                      
                     
                            
                    ],),
                    SizedBox(height: 16,),
                    Text(
                      res['description'],
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 16,),
                    ),
                  ],
                ),
              ),
                      )
                    ],
                  );
                }),
            ChewieListItem(
              videoPlayerController: VideoPlayerController.network(
                'https://as2.cdn.asset.aparat.com/aparat-video/532a96f2e7f217246783f8b58459fa8019041409-144p__79437.mp4',
              ),
              looping: false,
            ),
            
          ],
        ),
      )),
    );
  }
}

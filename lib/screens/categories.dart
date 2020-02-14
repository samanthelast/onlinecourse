import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/screens/video_list.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CategoryState();
  }
}

class _CategoryState extends State<Category> {
  List<dynamic> getCategories = [];
  List<dynamic> disctinctCategories = [];
  var unique ;

  Widget build(BuildContext context) {
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
             getCategories.addAll(document['category']);
                    final seen = Set<String>();
                     unique =
                        getCategories.where((str) => seen.add(str)).toList();

                    print(unique);
return Text(unique.toString());

              }).toList(),
            ));
        }
      },
    );
  }

  void _RouteToVideoListScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoList(
              //categoryID
              ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:online_courses/widgets/big_solo_card.dart';
import 'package:online_courses/widgets/horizontal_big_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
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
                return Horizontal_big_card(document['title'],document['creator']);
              }).toList(),
            ));
        }
      },
    );
  }
}

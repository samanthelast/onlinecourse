import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/widgets/horizontal_big_card.dart';

class Category extends StatefulWidget {
  final String itemCategory;
  Category(this.itemCategory);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.itemCategory),
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('menu').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:

            return Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 32,right:16,left:16),
                child: ListView(
                  
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                   print(document['category'].toString());
                if(document['category'].toString().contains(widget.itemCategory)){
return Horizontal_big_card(docID:document.documentID ,title: document['title'],creator: document['creator'],banner:document['banner']);

                }
else{return Container();}
              }).toList(),
            ));
        }
      },
    ),
    );
  }
}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/screens/categories/category.dart';


class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories> {
  List<dynamic> getCategories = [];
  List<dynamic> disctinctCategories = [];
  var unique;

  Widget build(BuildContext context) {
    return 
    
    StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('menu').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return Column(
              
              
              children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0,
                child: ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    getCategories.addAll(document['category']);
                    final seen = Set<String>();
                    unique =
                        getCategories.where((str) => seen.add(str)).toList();

                    
                    return Text('');
                  }).toList(),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                //width: MediaQuery.of(context).size.width,
                //height:  400,
                child: ListView.separated(
                  itemCount: unique.length,
                  shrinkWrap: true,
                  
                  itemBuilder: (BuildContext context, int index) {
                    
                    return  Directionality(
                  child: ListTile(
                    
                    title: Text('${unique[index]}'),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                    //leading: Icon(Icons.category,color: Colors.blue,),
                    onTap: () {
                       _RouteToVideoListScreen(context);
                    },
                  ),
                  textDirection: TextDirection.rtl,
                )
                ;
                  }, separatorBuilder: (context, index) {
    return Divider();
  }
                  
                ),
              ),
              
            ]);
        }
      },
    );
      
    
    
    
    
    
    
    
  }

  void _RouteToVideoListScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Category(),
        ));
  }
}

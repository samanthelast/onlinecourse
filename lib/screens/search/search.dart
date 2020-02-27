

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/screens/course.dart';
import 'package:online_courses/screens/search/searchservice.dart';
import 'package:online_courses/services/database.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);
  //final String title;
  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          //queryResultSet.add(docs.documents[i].data);
          queryResultSet.add(docs.documents[i]);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['title'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 32, left: 16, right: 16),
      child: ListView(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              child: TextField(
                onChanged: (val) {
                  initiateSearch(val);
                },
                decoration: InputDecoration(
                    labelText: "جستجو",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
              textDirection: TextDirection.rtl,
            )),
        SizedBox(height: 10.0),
        ListView(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            primary: false,
            shrinkWrap: true,
            children: tempSearchStore.map((element) {
              return buildResultCard(context,element);
            }).toList())
      ]),
    ));
  }
}

Widget buildResultCard(context,data) {
  return Container(
    child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          title: Text(data['title']),
          subtitle: Text('تهیه کننده: ' + data['creator']),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
          onTap: () {
            //print(data.DocumentID.toString());
            _RouteToCourseScreen( context,data);},
        )),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26))),
  );


}
  void _RouteToCourseScreen( context,data) {
  print(data.documentID.toString());
  
  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Course(docID:data.documentID.toString()),
//builder: (context) => CourseWrapper(docID: widget.docID),

          
        ));
}


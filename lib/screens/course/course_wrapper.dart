import 'package:flutter/material.dart';

class CourseWrapper extends StatefulWidget {
   final String docID;
  const CourseWrapper({this.docID});
  @override
  _CourseWrapperState createState() => _CourseWrapperState();
}

class _CourseWrapperState extends State<CourseWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('courseID:'+ widget.docID),
    );
  }
}
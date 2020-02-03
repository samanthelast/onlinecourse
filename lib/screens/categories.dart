import 'dart:convert';

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
  final names = [
    'کامپیوتر',
    'علوم مهندسی',
    'اقتصاد',
    'روانشناسی',
    'موسیقی',
    'بیولوژی',
  ];
  final icons = [
    Icons.computer,
    Icons.build,
    Icons.attach_money,
    Icons.accessibility,
    Icons.audiotrack,
    Icons.add_circle,
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(top:32, left: 32, right: 32),
      child: ListView.builder(
              /* separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ), */
              shrinkWrap: true,
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Directionality(
                  child: ListTile(
                    title: Text('${names[index]}'),
                    leading: Icon(icons[index],color: Colors.green,),
                    onTap: () {
                       _RouteToVideoListScreen(context);
                    },
                  ),
                  textDirection: TextDirection.rtl,
                ),
                );
              }
       ),
    )
      
       
    ;
  }
  void _RouteToVideoListScreen(BuildContext context) {
  
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>VideoList(
            //categoryID
          ),
        ));
  

}
}

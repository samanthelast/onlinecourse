import 'dart:convert';

import 'package:flutter/material.dart';



class VideoList extends StatefulWidget {
  VideoList({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _VideoListState();
  }
}

class _VideoListState extends State<VideoList> {
  final String imageVal =
      'https://www.aulatutorial.com/Content/images/foto-no-disponible.jpg';
  final names = [
    'کامپیوتر',
    'کامپیوتر',
    'کامپیوتر',
    'کامپیوتر',
    'علوم مهندسی',
    'اقتصاد',
    'روانشناسی',
    'موسیقی',
    'بیولوژی',
  ];
  final icons = [
    Icons.computer,
    Icons.computer,
    Icons.computer,
    Icons.computer,
    Icons.build,
    Icons.attach_money,
    Icons.accessibility,
    Icons.audiotrack,
    Icons.add_circle,
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("لیست ویدیو ها"),
        ),
        body: Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: ListView.builder(
              /* separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ), */
              
              shrinkWrap: true,
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(children:<Widget>[ListTile(
                    title: Text('اموزش کراس'),
                    leading: Image.network(
                      imageVal,
                      fit: BoxFit.fitWidth,
                      height: 100,
                      width: 100,
                    ),
                    subtitle: Text('همایون بهشتی'),
                    trailing: Text('تومان 23'),
                    onTap: () {


 _RouteToCourseScreen(context);


                    },
                  ),Divider()]
                  )
                  
                );
              }),
        ));
  }
  void _RouteToCourseScreen(BuildContext context) {
  
/*     Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Course(
            videoID: '1',
            videoVal: '1',
            title:'1',
            videoLengh:'1',
            price:'1',
            description:'1',
          ),
        ));
  
 */
}
}

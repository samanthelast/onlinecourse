import 'package:flutter/material.dart';
import 'package:online_courses/screens/video_list.dart';
import 'package:online_courses/widgets/solo_video_layout.dart';

class Horizontal_big_card extends StatefulWidget {
  final String title;
  final String creator;
  final List<dynamic> videos;
  Horizontal_big_card({this.title, this.creator, this.videos});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Horizontal_big_card> {
  final String imageVal =
      'https://firebasestorage.googleapis.com/v0/b/online-course-27851.appspot.com/o/Capture001.png?alt=media&token=bc98902f-9419-4585-8c2f-b9a59b991fd9';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: const Text('جزئیات'),
                    onPressed: () {
                      _RouteToVideoListScreen(context);
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 16, top: 16),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.title,
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.creator,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Text('1'),
                  Text('x'),
                  SizedBox(child: ListView(
  padding: const EdgeInsets.all(8),
  children: <Widget>[
    Container(
      height: 50,
      color: Colors.amber[600],
      child: const Center(child: Text('Entry A')),
    ),
    Container(
      height: 50,
      color: Colors.amber[500],
      child: const Center(child: Text('Entry B')),
    ),
    Container(
      height: 50,
      color: Colors.amber[100],
      child: const Center(child: Text('Entry C')),
    ),
  ],
),
                  height: 200,width: 200,)
                 
                ],
              )
              //Solo_video_layout('1001', 'اموزش  ریاضی 2', 'محمدرضا جوان', imageVal, '23', 'description'),

              // Solo_video_layout('1001', 'اموزش  ریاضی 2', 'محمدرضا جوان', imageVal, '23', 'description'),
              )
        ],
      ),
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

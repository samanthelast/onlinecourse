import 'package:flutter/material.dart';
import 'package:online_courses/screens/video_list.dart';
import 'package:online_courses/widgets/solo_video_layout.dart';

class Horizontal_big_card extends StatefulWidget {
  final String title;
  final String creator;
  final List<dynamic> videos;
  final String banner;
  Horizontal_big_card({this.title, this.creator, this.videos, this.banner});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Horizontal_big_card> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[50],
      child: Column(
        children: <Widget>[
          Container(
  width: MediaQuery.of(context).size.width,
  height: 200,
  decoration: BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage(widget.banner),
    ),
  ),
),
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
                padding: EdgeInsets.only(right: 16, top: 16, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.title,
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.creator,
                       textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

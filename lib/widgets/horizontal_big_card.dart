import 'package:flutter/material.dart';
import 'package:online_courses/screens/video_list.dart';
import 'package:online_courses/widgets/solo_video_layout.dart';

/// This is the stateless widget that the main application instantiates.
class Horizontal_big_card extends StatelessWidget {
  final String title;
  final String creator;
  final String imageVal =
      'https://firebasestorage.googleapis.com/v0/b/online-course-27851.appspot.com/o/Capture001.png?alt=media&token=bc98902f-9419-4585-8c2f-b9a59b991fd9';
  Horizontal_big_card(this.title,this.creator);
  String gettitle() {
    return title;
  }

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
                      title,
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      creator,
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
                Solo_video_layout('1001', 'اموزش  ریاضی 2', 'محمدرضا جوان',
                    imageVal, '23', 'description'),
                Solo_video_layout('1001', 'openCV کتاب خانه', 'پانیز شگفت',
                    imageVal, '23', 'description'),
                Solo_video_layout('1001', 'اموزش کراس', 'همایون بهشتی',
                    imageVal, '23', 'description'),
                Solo_video_layout('1001', 'کار با فوتوشاپ', 'محمد دیلمی',
                    imageVal, '23', 'description'),
                Solo_video_layout('1001', 'اموزش c++', 'علی میرزازاده',
                    imageVal, '23', 'description'),
              ],
            ),
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

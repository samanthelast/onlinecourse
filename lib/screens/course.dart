import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:online_courses/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

class Course extends StatelessWidget {
/*   final String videoVal;
  final String title;
  final String videoLengh;
  final String price;
  final String description;
 */
  // receive data from the mainScreen as a parameter

/*   const Course(
      {Key key,
      this.videoVal,
      this.title,
      this.videoLengh,
      this.price,
      this.description,
      })
      : super(key: key);

 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("جزییات ویدیو"),
      ),
      body: Scaffold(
          body: new SingleChildScrollView(
           padding: EdgeInsets.only(top: 16),
        child: new Column(

          children: <Widget>[
         
            ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
              'https://as2.cdn.asset.aparat.com/aparat-video/532a96f2e7f217246783f8b58459fa8019041409-144p__79437.mp4',
            ),
            looping: false,
          ),

             const SizedBox(height: 32),
            ListTile(title: Text('اموزش تعویض کیت گوشی',textDirection: TextDirection.rtl,textAlign: TextAlign.justify,),)
            ,
            ListTile(
                      title: Text( "تومان 22 " ),
                      trailing: RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text('خرید ویدیو',textScaleFactor: 1.5,), onPressed: () {},
                      ),
                      onTap: () {
                        /*      _RouteToDetailScreen(
                        context,
                        Products[index].getcardColor(),
                        Products[index].getimgUrl(),
                        Products[index].getpreviousPrice(),
                        Products[index].getprice(),
                        Products[index].getTitle()); */
                      },
                    )
            ,
            ListTile(title: Text('در این ویدیو طریقه باز کردن گوشی آیفون و تعویض کیت رو اموزش میدیم',textDirection: TextDirection.rtl,textAlign: TextAlign.justify,),)
            
          ],
        ),
      )),
    );
  }
}

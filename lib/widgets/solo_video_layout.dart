import 'package:flutter/material.dart';
import 'package:online_courses/screens/course.dart';

import 'chewie_list_item.dart';

import 'package:video_player/video_player.dart';
/// This is the stateless widget that the main application instantiates.
class Solo_video_layout extends StatelessWidget {
  final String videoID;
  final String title;
  final String creator;
  //final String imageVal;
  final String price;
  final String description;
  
  

  Solo_video_layout(this.videoID,this.title,this.creator,this.price,this.description);
   

    String getVideoID(){
      return videoID;
    }
 
  String getTitle(){return title;}
String getCreator(){return creator;}

  String getPrice() {
    return price;
  }

  String getDescription() {
    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child:
     Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      
      elevation: 0,
      
      child:InkWell(
        onTap: (){_RouteToCourseScreen(context);},
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.end,
          
        children: <Widget>[
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
              'https://as2.cdn.asset.aparat.com/aparat-video/532a96f2e7f217246783f8b58459fa8019041409-144p__79437.mp4',
            ),
            looping: false,
          )
           
          ,
          Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black,fontSize: 16),
                ),
                Text(
                  creator,
                   style: TextStyle(color: Colors.grey,fontSize: 12),
                )
        ],
      ),
      ) ,
    ));
  }


//void _RouteToCourseScreen(BuildContext context, String VideoID,String videoVal,String title,String videoLengh,String price,String description) {
    
    void _RouteToCourseScreen(BuildContext context) {
  
    Navigator.push(
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
  

}
}
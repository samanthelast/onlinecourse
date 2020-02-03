import 'package:flutter/material.dart';
import 'package:online_courses/widgets/big_solo_card.dart';
import 'package:online_courses/widgets/horizontal_big_card.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     
      child: Container(
        padding: EdgeInsets.only(top: 64,right:16,left:16),
        child: Column(
        
        children: <Widget>[
          BigSoloCard('assets/images/tabligh1.jpg'),
          Horizontal_big_card('جدیدترین'),
           Horizontal_big_card('پر بازدید'),
           BigSoloCard('assets/images/tabligh2.jpg'),
            Horizontal_big_card('رایگان'),

             Horizontal_big_card('کامپیوتر'),
              Horizontal_big_card('اقتصاد'),
               Horizontal_big_card('اقتصاد'),

        ],
      ),
      ),
    );
  }
}

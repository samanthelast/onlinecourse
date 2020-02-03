import 'package:flutter/material.dart';


/// This is the stateless widget that the main application instantiates.
class BigSoloCard extends StatelessWidget {

  
  final String imageVal;

  BigSoloCard(this.imageVal);
  String getDescription(){return imageVal;}
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
          onTap: () {
            
          },
          child: Container(
            
            
            child: Image.asset(imageVal),
          ),
        ),
      );
  }
}

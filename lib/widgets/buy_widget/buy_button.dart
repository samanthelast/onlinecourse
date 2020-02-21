import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class BuyButton extends StatefulWidget {
  final int price;
  final String _userID;
  final List<dynamic> bought_vidoes;
  final String docID;
  const BuyButton(this.price, this._userID, this.bought_vidoes, this.docID);
  @override
  _BuyButtonState createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  String _userID;
  List<String> buttonText = ["خرید توتاریال", "خریداری شده"];
  int isBought = 0;
  var buttonColor = [Colors.blue, Colors.green];
  _getUserID() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        _userID = user.uid;
      });
    } catch (error) {
      print(error.toString());
      return 'failed';
    }
  }



  @override
  void initState() {
    super.initState();
    _getUserID();
 
    
  }

  @override
  Widget build(BuildContext context) {
    if (widget.price != 0) {
      //aya polie? OK

      if (_userID != null) {
        //aya login hasti?
        print('login hast');
        print(widget.bought_vidoes);
        if (widget.bought_vidoes.contains(widget.docID)) {
          setState(() {
            isBought = 1;
          });

          print('ghablan kharide');
          //ghablan kharide hich kari nakon
        } else {
          setState(() {
            isBought = 0;
          });

          print('ghablan nakharide');
          //boro to kare kharid
        }
        return Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //aya login hast ya na
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 32.0,
                      width: 128,
                      decoration: new BoxDecoration(
                          color: buttonColor[isBought],
                          borderRadius: new BorderRadius.circular(9.0)),
                      child: new Text(buttonText[isBought],
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.white))),
                )
              ],
            ));
      } else {
        print('login nist');
        return Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'ابتدا وارد حساب کاربری خود شوید',
                        textAlign: TextAlign.center,
                      ),
                    ));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 32.0,
                      width: 128,
                      decoration: new BoxDecoration(
                          color: buttonColor[isBought],
                          borderRadius: new BorderRadius.circular(9.0)),
                      child: new Text(buttonText[isBought],
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.white))),
                )
              ],
            ));
      }
    }
    if (widget.price == 0) {
      return Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 32.0,
                width: 128,
              )
            ],
          ));
    }
  }
}

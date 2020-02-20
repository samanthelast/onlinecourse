import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class BuyButton extends StatefulWidget {
  final int price;
  const BuyButton(this.price);
  @override
  _BuyButtonState createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  String _userID;
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
print(_userID);
  }
  @override
  Widget build(BuildContext context) {

    if (widget.price != 0) {
      return Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[


              





              GestureDetector(
                onTap: () {
                 
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 32.0,
                    width: 128,
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.circular(9.0)),
                    child: new Text("خرید توتاریال",
                        style: new TextStyle(
                            fontSize: 16.0, color: Colors.white))),
              )
            ],
          ));
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


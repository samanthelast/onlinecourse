import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  var credit;
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
           //aya mojodie kafi dare?
           
           

        }
        return Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                StreamBuilder(
                      stream: Firestore.instance
                          .collection('users')
                          .document(_userID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                         credit = userDocument['credit'];
                        //return new Text(userDocument['credit'].toString());
                        
                        
                        return Text('') ;
                        
                      }),
                GestureDetector(
                  onTap: () {
                   print('clicked');
                   print(widget.price);
                   print(credit.toString());
                   if(widget.price > credit){
Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        '.اعتبار حساب شما کافی نیست',
                        textAlign: TextAlign.center,
                      ),
                    ));
                   }
                   if( widget.price <= credit){
                  print('you can buy');  
                  _showBuyDialog(widget.price,credit);
                                     }
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
                  
                    void _showBuyDialog(int price,int credit) {
                      int amountLeft = credit - price;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          child: AlertDialog(
            title: new Text("آیا از خرید خود مطمعمن هستید؟",),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('اعتبار شما: '+ credit.toString()+' تومان'),
                Text('قیمت توتاریال: '+ price.toString()+' تومان'),
                Text('اعتبار باقی مانده شما: '+ amountLeft.toString()+' تومان '),
                Text('آیا از خرید خود اطمینان دارید؟'),
               SizedBox(height: 32,),
              GestureDetector(
child:Container(
                                  alignment: Alignment.center,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          new BorderRadius.circular(9.0)),
                                  child: new Text("خرید نهایی",
                                      style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white))) ,
                onTap: () async {
                  
                               
                              },
              )
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("بستن"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          textDirection: TextDirection.rtl,
        );
      },
    );
  }
}

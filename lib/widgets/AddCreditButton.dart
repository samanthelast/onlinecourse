import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/services/auth.dart';
import 'package:online_courses/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCreditButton extends StatefulWidget {
  final String _userID;
  final dynamic old_credit;
  const AddCreditButton(this._userID,this.old_credit) ;

  @override
  _AddCreditButtonState createState() => _AddCreditButtonState();
}

class _AddCreditButtonState extends State<AddCreditButton> {
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    amountControler.dispose();
  }
  bool isStopped = false;
   final amountControler = TextEditingController();

   
   


  @override
  Widget build(BuildContext context) {
    return FlatButton(
                              child: const Text(
                                'افزایش اعتبار',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {_showDialog();
                             
                              
                              },
                            );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          child: AlertDialog(
            title: new Text("افزایش اعتبار",),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('مقدار اعتبار خود را به تومان وارد کنید'),
                TextField(
controller:amountControler,
            decoration: InputDecoration(
              icon: Icon(Icons.attach_money),
              hintText: 'حداقل 100 تومان',
            ),
          ),
              SizedBox(height: 32,),
              GestureDetector(
child:Container(
                                  alignment: Alignment.center,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius:
                                          new BorderRadius.circular(9.0)),
                                  child: new Text("درگاه زرین پال",
                                      style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black))) ,
                onTap: () async {
                  var amount = int.parse(amountControler.text);
                               if(amount >= 100){
                                 
                                 ZarinReq(widget._userID,amount,isStopped,widget.old_credit);



                               }
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



ZarinReq(_userID,price,isStopped,old_credit) async {
  
  String url =
      'https://sandbox.zarinpal.com/pg/rest/WebGate/PaymentRequest.json';
  Map map = {
    "MerchantID": "5344db9c-c398-4b62-9c69-03525ee8a9d4",
    "Amount": price.toString(),
    "CallbackURL": "http://www.example.com",
    "Description": "توضیحات تراکنش",
    "Email": "dev@example.com",
    "Mobile": "09000000000"
  };

  final body = json.decode(await apiRequest(url, map));
//intent to chrome


  if (body['Status'] == 100) {
   
     String zarinLink='http://sandbox.zarinpal.com/pg/StartPay/'+body['Authority'];
    print(zarinLink);
    //await launch(zarinLink);


  if (await canLaunch(zarinLink)) {
    await launch(zarinLink);
    print('here');
  } else {
    throw 'Could not launch $zarinLink';
  }
//did user baught? check every 5 sec
sec5Timer(_userID,body,price,isStopped,old_credit);
     

  }else{
    print('snack bar zarin pal failed');
  }
}

sec5Timer(_userID,body,price,isStopped,old_credit) {
  
  Timer.periodic(Duration(seconds: 5), (timer) async {
    if (isStopped) {
      timer.cancel();
    }
    
     String payUrl =
        'http://sandbox.zarinpal.com/pg/rest/WebGate/PaymentVerification.json';
    Map payMap = {
      "MerchantID": "5344db9c-c398-4b62-9c69-03525ee8a9d4",
      "Amount": price.toString(),
      "Authority": body['Authority']
    };
    
 final body2 = json.decode(await apiPay(payUrl, payMap));
 
 if (body2['Status'] == 100){
  
  addDeposit(_userID,price,old_credit);
     print('kharid anjam shod');
      isStopped=true;
   }
   if (body2['Status'] == -22){
     
     isStopped=true;
     print('na movafagh');
   }
    if (body2['Status'] == -21){
     print('yaft nashod ');
     
   }
   else{
     print(body2['status']);
   
     print('unknow error :(');
      isStopped=true;
   }
    });
  }
  
  Future<void> addDeposit(String _userID ,int price,dynamic old_credit) async {
    //get user  widget._userID done!  widget.old_credit
    var new_credit = price + old_credit;
  print(new_credit);
  print(_userID+ 'u');
  print(price.toString() + 'p');
  print(old_credit.toString()+ 'o');

    //add new_credit to  _userID
    await DatabaseService(uid: _userID).AddDepositToUser(new_credit);
   // final fs.Firestore firestore = fb.firestore();
    //firestore.collection('users').doc('').update(data:{'text': 'thehappyharis'});
}

Future<String> apiRequest(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('Content-Type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();

  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

Future<String> apiPay(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('Content-Type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();

  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}
import 'dart:convert';
import 'dart:io';

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
  @override
  Widget build(BuildContext context) {
    if (widget.price != 0) {
      return Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  ZarinReq(widget.price);
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

ZarinReq(price) async {
  String url =
      'https://sandbox.zarinpal.com/pg/rest/WebGate/PaymentRequest.json';
  Map map = {
    "MerchantID": "5344db9c-c398-4b62-9c69-03525ee8a9d4",
    "Amount": "100",
    "CallbackURL": "http://www.example.com",
    "Description": "توضیحات تراکنش",
    "Email": "dev@example.com",
    "Mobile": "09000000000"
  };

  final body = json.decode(await apiRequest(url, map));
//intent to chrome


  if (body['Status'] == 100) {
   
    String zarinLink='http://sandbox.zarinpal.com/pg/StartPay/'+body['Authority'];
    
    await launch(zarinLink);
/*     String payUrl =
        'http://sandbox.zarinpal.com/pg/rest/WebGate/PaymentVerification.json';
    Map payMap = {
      "MerchantID": "5344db9c-c398-4b62-9c69-03525ee8a9d4",
      "Amount": price,
      "Authority": body['Authority']
    };
    print(await apiPay(payUrl, payMap)); */
  }else{
    print('snack bar zarin pal failed');
  }
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

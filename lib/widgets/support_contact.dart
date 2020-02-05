import 'package:flutter/material.dart';

class SupportContact extends StatefulWidget {
  @override
  _SupportContactState createState() => _SupportContactState();
}

class _SupportContactState extends State<SupportContact> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      child: ListTile(
        title: Text('تماس با پشتیبانی'),
        leading: Icon(Icons.phone),
        onTap: () {
          _showDialog();
        },
      ),
      textDirection: TextDirection.rtl,
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
            title: new Text("تماس با پشتیبانی",),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('شماره تماس'),
                Text('09373808573',style: TextStyle(fontFamily: 'Vazir' )),
                Text('ایمیل'),
                Text('samanthelast@gmail.com'),
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

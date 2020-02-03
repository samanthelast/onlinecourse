import 'package:flutter/material.dart';
import 'package:online_courses/services/auth.dart';

import 'profile_login.dart';

class ProfileLogedInFalse extends StatelessWidget {
  ProfileLogedInFalse();

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('حساب کاربری'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.only(top: 32),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  
                  children: <Widget>[
                    ListTile(
                      title: ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            child: const Text('ورود'),
                            onPressed: () {
                              _RouteToLoginScreen(context);
                            },
                          ),
                        ],
                      ),
                      trailing: Text('ورود به حساب کاربری'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(padding: EdgeInsets.only(bottom: 32),child: Column(
                  children: <Widget>[
                    Directionality(
                      child: ListTile(
                        title: Text('تماس با پشتیبانی'),
                        leading: Icon(Icons.phone),
                        onTap: () {},
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Directionality(
                      child: ListTile(
                        title: Text('درباره ما'),
                        leading: Icon(Icons.developer_mode),
                        onTap: () {},
                      ),
                      textDirection: TextDirection.rtl,
                    )
                  ],
                ),),
              )
            ],
          )),
    );
  }

  void _RouteToLoginScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }
}

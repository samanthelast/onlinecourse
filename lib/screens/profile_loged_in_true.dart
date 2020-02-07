import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/services/auth.dart';
import 'package:online_courses/widgets/support_contact.dart';

import 'profile_login.dart';

class ProfileLogedInTrue extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileLogedInTrueState();
  }
}

class _ProfileLogedInTrueState extends State<ProfileLogedInTrue> {
  final AuthService _auth = AuthService();
  String _userEmail = 'empty';
  
  _getUserAuthEmail() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        _userEmail = user.email;


      });
      return this._userEmail;
    } catch (error) { print(error.toString());
      return 'failed';}
  }

  @override
  void initState() {
    super.initState();
     _getUserAuthEmail();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('حساب کاربری'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 32),
        //alignment: Alignment.topRight,

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
                          child: const Text('افزایش اعتبار'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                    trailing: Text('اعتبار من: 0 تومان'),
                    onTap: () {},
                  ),
                  Directionality(
                    child: ListTile(
                      title: Text('محبوب ها'),
                      leading: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onTap: () {},
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Directionality(
                    child: ListTile(
                      title: Text('خریداری شده ها'),
                      leading: Icon(
                        Icons.shopping_basket,
                        color: Colors.blue,
                      ),
                      onTap: () {},
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SupportContact(),
                  Directionality(
                    child: ListTile(
                      title: Text(_userEmail),
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      onTap: () {},
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          'خروج',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () async {
                          dynamic result = await _auth.signOut();

                          print(result);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
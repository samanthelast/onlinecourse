import 'package:flutter/material.dart';
import 'package:online_courses/services/auth.dart';
import 'package:online_courses/widgets/support_contact.dart';

import 'profile_login.dart';

class ProfileLogedInTrue extends StatelessWidget {
  ProfileLogedInTrue();

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
                      leading: Icon(Icons.favorite),
                      onTap: () {},
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Directionality(
                    child: ListTile(
                      title: Text('خریداری شده ها'),
                      leading: Icon(Icons.shopping_basket),
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
                  
                  ListTile(
                    trailing:
                        Text(' Saman_Ariyanpour1378@gmail.com حساب کاربری '),
                    onTap: () {},
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

import 'package:cloud_firestore/cloud_firestore.dart';
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
  String _userID;

  _getUserAuthEmail() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        _userEmail = user.email;
        _userID = user.uid;
      });
      return this._userEmail;
    } catch (error) {
      print(error.toString());
      return 'failed';
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserAuthEmail();
    //_getUserCredit();
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
                        //return new Text(userDocument['credit'].toString());
                        return Directionality(
                          child: ListTile(
                            trailing: FlatButton(
                              child: const Text(
                                'افزایش اعتبار',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {/* ... */},
                            ),
                            title: Text('اعتبار من ' + userDocument['credit'].toString() + ' تومان'),
                            leading: Icon(
                              Icons.credit_card,
                              color: Colors.blue,
                            ),
                            onTap: () {},
                          ),
                          textDirection: TextDirection.rtl,
                        );
                      }),
                  
                  Directionality(
                    child: ListTile(
                      title: Text('خریداری شده های من'),
                      leading: Icon(
                        Icons.shopping_basket,
                        color: Colors.blue,
                      ),
                      onTap: () {},
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Directionality(
                    child: ListTile(
                      title: Text('محبوب های من'),
                      leading: Icon(
                        Icons.favorite,
                        color: Colors.red,
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
                      trailing: FlatButton(
                        child: const Text(
                          'ویرایش',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {/* ... */},
                      ),
                      title: Text(_userEmail),
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      onTap: () {},
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Directionality(
                    child: ListTile(
                      trailing: FlatButton(
                        child: const Text(
                          'خروج',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () async {
                          dynamic result = await _auth.signOut();

                          print(result);
                        },
                      ),
                      onTap: () {},
                    ),
                    textDirection: TextDirection.rtl,
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

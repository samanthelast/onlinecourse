import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_courses/screens/bought.dart';
import 'package:online_courses/services/auth.dart';
import 'package:online_courses/widgets/AddCreditButton.dart';
import 'package:online_courses/widgets/support_contact.dart';

import 'favourite.dart';
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
 String password1 = '';
  String password2 = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passController.dispose();
  }

  bool isStopped = false;
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       resizeToAvoidBottomPadding: false,
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
                            trailing: AddCreditButton(_userID,userDocument['credit']),
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
                      onTap: () {
                        _RouteToBaoughtScreen(context);
                                              },
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
                                              onTap: () {
                                                _RouteToFavScreen(context);
                                              },
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
                                                onPressed: () {
                                                  

                                                  _showDialog();
                                                },
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
                        
                          void _RouteToFavScreen(BuildContext context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Favourite(),
                                ));
                          }
                        
                          void _RouteToBaoughtScreen(BuildContext context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Bought(),
                                ));
                          }




                          _showDialog() {
    // flutter defined function
    showDialog(
      
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Form(
          key: _formKey,
                  child: Directionality(
            child: AlertDialog(
              title: new Text(
                "تغییر رمز عبور",
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 // Text(' رمزعبور جدید خود را وارد نمایید.'),
                  TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration:
                                new InputDecoration(labelText: 'رمزعبور جدید خود را وارد نمایید'),
                            validator: (val) =>
                                val.length < 6 ? 'رمز عبور کوتاه است' : null,
                            onChanged: (val) {
                              setState(() => password1 = val);
                            },
                          )
                  ,
                 
                  SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            color: Colors.blue,
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Text("تایید",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white))),
                    onTap: () async {
                          if (_formKey.currentState.validate()) {
                                 try{
await _auth.changePassword(password1);

                                 }catch(e){
                                   print(e);
                                 }
                                   
                                   
 Navigator.of(context).pop();

                                  
                                 
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
          ),
        );
      },
    );
  }

}



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_courses/screens/profile_login_register.dart';
import 'package:online_courses/services/MyProxy.dart';
import 'package:online_courses/services/auth.dart';
import 'package:online_courses/shared/loading.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("صفحه ورود"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 32, right: 32),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: new TextFormField(
                      textAlign: TextAlign.center,
                      validator: (val) => val.isEmpty ? 'لطفا ایمیل خود را وارد کنید' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: new InputDecoration(
                          labelText: 'ایمیل', labelStyle: TextStyle()),
                    ),
                  ),
                ),
                new SizedBox(
                  height: 15.0,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(labelText: 'رمز عبور'),
                        validator: (val) => val.length < 6
                            ? 'رمز عبور کوتاه است'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    )),
                new SizedBox(
                  height: 15.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 20.0, top: 10.0),
                        child: new Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            child: new Text("فراموشی رمز عبور",
                                style: new TextStyle(
                                    fontSize: 17.0, color: Colors.green))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 5.0, top: 10.0),
                        child: GestureDetector(
                         onTap: () async {

                   if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                   
              
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
                      });
                    }else{
                                      setState(() {
                                        loading = false;
                                        Navigator.pop(context);
                                      });
                                          
                                    }
                    
                  }


                },
                          child: new Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              decoration: new BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: new BorderRadius.circular(9.0)),
                              child: new Text("ورود",
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white))),
                        ),
                      ),
                    ),
                     
                  ],
                ),
                SizedBox(height: 12.0),
                RaisedButton(
                child: Text("Login with Google"),
                onPressed: () async {
                  dynamic res = await _auth.loginWithGoogle();
                  if(!res)
                    print("error logging in with google");
                },
              ),
              
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: GestureDetector(
                          child: new Text("هنوز ثبت نام نکرده ام",
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            _RouteToRegisterScreen(context);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _RouteToRegisterScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ));
  }
}

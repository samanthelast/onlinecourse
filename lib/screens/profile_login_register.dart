import 'package:flutter/material.dart';
import 'package:online_courses/services/auth.dart';
import 'package:online_courses/shared/loading.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateRegister();
  }
}

class _StateRegister extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // text field state
  String email = '';
  String password1 = '';
  String password2 = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text("صفحه ثبت نام"),
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
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 80.0),
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
                            validator: (val) => val.isEmpty
                                ? 'لطفا ایمیل خود را وارد کنید'
                                : null,
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
                            decoration:
                                new InputDecoration(labelText: 'رمز عبور'),
                            validator: (val) =>
                                val.length < 6 ? 'رمز عبور کوتاه است' : null,
                            onChanged: (val) {
                              setState(() => password1 = val);
                            },
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
                              decoration:
                                  new InputDecoration(labelText: 'رمز عبور'),
                              validator: (val) =>
                                  val.length < 6 ? 'رمز عبور کوتاه است' : null,
                              onChanged: (val) {
                                setState(() => password2 = val);
                              },
                            ),
                          )),
                      new SizedBox(
                        height: 15.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 5.0, top: 10.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  if (password1 == password2) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password1);
                                    print(result);
                                      
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            'Could not Register with those credentials';
                                      });
                                    }else{
                                      setState(() {
                                        loading = false;
                                        Navigator.pop(context);
                                         Navigator.pop(context);
                                      });
                                          
                                    }
                                  }
                                  if (password1 != password2) {
                                    error = 'رمز عبور ها یکسان نیستند';
                                  }
                                }
                              },
                              child: new Container(
                                  alignment: Alignment.center,
                                  height: 60.0,
                                  width: 128,
                                  decoration: new BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          new BorderRadius.circular(9.0)),
                                  child: new Text("ثبت نام",
                                      style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                )));
  }

  void _RouteToRegisterScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ));
  }
}


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_courses/screens/categories.dart';
import 'package:online_courses/screens/home.dart';

import 'package:online_courses/screens/profile_wrapper.dart';
import 'package:online_courses/screens/search.dart';
import 'package:online_courses/services/MyProxy.dart';
import 'package:online_courses/services/auth.dart';
import 'package:provider/provider.dart';


import 'models/user.dart';


void main() {
  //HttpOverrides.global = new MyHttpOverrides() ;
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: MyStatefulWidget(),
        theme: ThemeData(
          accentColor: Colors.green,
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          brightness: Brightness.light,
          accentIconTheme: IconThemeData(color: Colors.green),
          iconTheme: IconThemeData(color: Colors.green),
          fontFamily: 'Vazir',
          
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 3;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ProfileWrapper(),
    Search(),
    Category(),
    Home(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('حساب من'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('جستجو'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('دسته ها'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('خانه'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

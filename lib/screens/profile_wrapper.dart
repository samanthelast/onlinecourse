import 'package:flutter/material.dart';
import 'package:online_courses/models/user.dart';
import 'package:online_courses/screens/profile_loged_in_false.dart';
import 'package:online_courses/screens/profile_loged_in_true.dart';
import 'package:provider/provider.dart';

class ProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
  



    // return either the Home or Authenticate widget
    if (user == null){
      return ProfileLogedInFalse();
    } else {
      return ProfileLogedInTrue();
    }
    
  }
}
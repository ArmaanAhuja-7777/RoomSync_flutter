import 'package:flutter/material.dart';
import 'package:room_automation/home/base_home.dart';
import 'package:room_automation/login/ProfileScreen.dart';
import 'package:room_automation/login/LoginScreen.dart';
import 'package:room_automation/services/auth.dart';
import 'package:room_automation/services/firestore.dart';
import 'package:room_automation/shared/home_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        } else if (snapshot.hasError) {
          return Text("Error");
        } else if (snapshot.hasData) {
          // print(snapshot.data);
          // user is logged in
          // check initial data of user if exists then permit
          // redirectProfileCheck(context);
          return HomeNav();
        } else {
          // user is logged out
          return const LoginScreen();
        }
      },
    );
  }
}

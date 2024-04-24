import 'package:room_automation/home/home.dart';
import 'package:room_automation/login/ProfileScreen.dart';
import 'package:room_automation/login/LoginScreen.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/giveInitialData': (context) => ProfileScreen()
};

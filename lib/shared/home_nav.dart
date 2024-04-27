import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_automation/home/base_home.dart';
import 'package:room_automation/home/devices.dart';
import 'package:room_automation/login/ProfileScreen.dart';
import 'package:room_automation/services/firestore.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final controller = Get.put(NavigationController());

  Future<void> redirectProfileCheck(context) async {
    var userProfile = await FirestoreService().getUserProfile();

    if (userProfile.name.isEmpty) {
      controller.changeIndex(2);
    } else {
      controller.changeIndex(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    redirectProfileCheck(context);
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
              height: 70,
              selectedIndex: controller.currentIndex.value,
              onDestinationSelected: (int index) {
                controller.changeIndex(index);
              },
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(icon: Icon(Icons.bolt), label: "Devices"),
                NavigationDestination(
                    icon: Icon(Icons.supervised_user_circle), label: "Profile"),
              ])),
      body: Obx(() => controller.screens[controller.currentIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Widget changeIndexTo(int index) {
    currentIndex.value = 1;
    return HomeNav();
  }

  final screens = [
    BaseHome(),
    Devices(),
    ProfileScreen(),
  ];
}

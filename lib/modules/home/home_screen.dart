import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/modules/home/home_controller.dart';
import 'package:idea_elevator/modules/idea_listing/idea_list_screen.dart';

import 'package:idea_elevator/modules/idea_submission/idea_submission_screen.dart';
// import 'package:idea_elevator/modules/leaderboard/leaderboard_screen.dart';
// import 'package:idea_elevator/modules/settings/settings_screen.dart';

class HomeScreen extends GetView<HomeController> {
  final List<Widget> screens = [
    IdeaListingScreen(),
    IdeaSubmissionScreen(),
    // LeaderboardScreen(),
    // SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use Obx to listen to tabIndex changes
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: screens,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.tabIndex.value,
            onTap: controller.changeTabIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: 'Ideas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle), label: 'New Idea'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard), label: 'LeaderBoard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          )),
    );
  }
}

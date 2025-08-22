import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/modules/settings/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Obx(
              () => SwitchListTile(
                title: Text('Dark Mode'),
                subtitle:
                    Text('Enable to reduce glare and improve battery life'),
                value: controller.isDarkMode,
                onChanged: (bool value) {
                  controller.toggleTheme(value);
                },
                secondary: Icon(
                  controller.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About this App'),
              subtitle: Text('Version 1.0.0'),
              onTap: () {
                Get.snackbar('About', 'Startup Idea Hub v1.0.0');
              },
            ),
          ],
        ),
      ),
    );
  }
}

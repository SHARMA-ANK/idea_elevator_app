import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/modules/settings/settings_controller.dart';
import 'package:idea_elevator/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SettingsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      // Wrap with Obx to listen for theme changes
      () => GetMaterialApp(
        title: 'Startup Idea Hub',
        debugShowCheckedModeBanner: false,

        // Define your light and dark themes
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.light(
            primary: Colors.blue,
            secondary: Colors.amber,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.teal,
          colorScheme: ColorScheme.dark(
            primary: Colors.teal,
            secondary: Colors.orange,
          ),
          // Example of different AppBar theme for dark mode
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
          ),
        ),

        themeMode: settingsController.themeMode.value,

        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}

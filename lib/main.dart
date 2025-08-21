import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Startup Idea Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Add your light theme
      darkTheme: ThemeData.dark(), // Add your dark theme
      themeMode: ThemeMode.system, // Or manage with SettingsController
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

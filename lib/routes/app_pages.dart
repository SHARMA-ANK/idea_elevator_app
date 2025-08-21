import 'package:get/get.dart';
import 'package:idea_elevator/modules/home/home_binding.dart';
import 'package:idea_elevator/modules/home/home_screen.dart';
import 'package:idea_elevator/modules/splash/splash_screen.dart';
import 'package:idea_elevator/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(), // This will inject all necessary controllers
    ),
  ];
}

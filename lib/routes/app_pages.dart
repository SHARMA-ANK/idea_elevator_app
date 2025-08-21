import 'package:get/get.dart';
import 'package:idea_elevator/modules/splash/splash_screen.dart';
import 'package:idea_elevator/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
  ];
}

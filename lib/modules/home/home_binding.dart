import 'package:get/get.dart';
import 'package:idea_elevator/modules/home/home_controller.dart';
import 'package:idea_elevator/modules/idea_submission/idea_controller.dart';
// import 'package:idea_elevator/modules/leaderboard/leaderboard_controller.dart';
// import 'package:idea_elevator/modules/settings/settings_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => IdeaController());
    // Get.lazyPut(() => LeaderboardController());
    // Get.lazyPut(() => SettingsController());
  }
}

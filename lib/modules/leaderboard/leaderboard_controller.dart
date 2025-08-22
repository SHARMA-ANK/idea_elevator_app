import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/data/models/idea_model.dart';
import 'package:idea_elevator/modules/idea_submission/idea_controller.dart';

class LeaderboardController extends GetxController {
  final IdeaController _ideaController = Get.find();

  late ConfettiController confettiController;

  @override
  void onInit() {
    super.onInit();

    confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    playCelebration();
  }

  RxList<Idea> get topIdeas {
    var sortedList = List<Idea>.from(_ideaController.ideas);

    sortedList.sort((a, b) => b.votes.compareTo(a.votes));

    return sortedList.take(5).toList().obs;
  }

  void playCelebration() {
    confettiController.play();
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}

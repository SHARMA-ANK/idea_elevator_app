import 'package:get/get.dart';
import 'package:idea_elevator/data/models/idea_model.dart';
import 'package:idea_elevator/data/services/storage_service.dart';

class IdeaController extends GetxController {
  var ideas = <Idea>[].obs;
  var sortOrder = 'rating'.obs;

  @override
  void onInit() {
    super.onInit();
    loadIdeas();
  }

  Future<void> loadIdeas() async {
    final loadedIdeas = await StorageService.getIdeas();
    ideas.assignAll(loadedIdeas);
    sortIdeas();
  }

  // Add a new idea (no longer creates a fake rating)
  Future<void> addIdea(String name, String tagline, String description) async {
    final newIdea = Idea(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      tagline: tagline,
      description: description,
    );
    ideas.add(newIdea);
    await StorageService.saveIdeas(ideas);
    sortIdeas();
  }

  // Upvote an idea
  Future<void> upvoteIdea(String id) async {
    final index = ideas.indexWhere((idea) => idea.id == id);
    if (index != -1) {
      ideas[index].votes++;
      ideas.refresh();
      await StorageService.saveIdeas(ideas);
      if (sortOrder.value == 'votes') {
        sortIdeas(); // Re-sort if the current order is by votes
      }
    }
  }

  // New method to add a user's rating
  Future<void> rateIdea(String id, double userRating) async {
    final index = ideas.indexWhere((idea) => idea.id == id);
    if (index != -1) {
      ideas[index].totalRatingScore += userRating;
      ideas[index].numberOfRatings++;
      ideas.refresh(); // Crucial for Obx to detect the change
      await StorageService.saveIdeas(ideas);
      if (sortOrder.value == 'rating') {
        sortIdeas(); // Re-sort if the current order is by rating
      }
    }
  }

  void sortIdeas() {
    if (sortOrder.value == 'rating') {
      // Now sorts by the average rating getter
      ideas.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    } else {
      ideas.sort((a, b) => b.votes.compareTo(a.votes));
    }
  }

  void changeSortOrder(String order) {
    sortOrder.value = order;
    sortIdeas();
  }
}

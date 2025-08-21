import 'dart:math';
import 'package:get/get.dart';
import 'package:idea_elevator/data/models/idea_model.dart';
import 'package:idea_elevator/data/services/storage_service.dart';

class IdeaController extends GetxController {
  // Use .obs to make the list reactive
  var ideas = <Idea>[].obs;
  var sortOrder = 'rating'.obs; // 'rating' or 'votes'

  @override
  void onInit() {
    super.onInit();
    loadIdeas();
  }

  // Load ideas from local storage
  Future<void> loadIdeas() async {
    final loadedIdeas = await StorageService.getIdeas();
    ideas.assignAll(loadedIdeas);
    sortIdeas();
  }

  // Add a new idea
  Future<void> addIdea(String name, String tagline, String description) async {
    final newIdea = Idea(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      tagline: tagline,
      description: description,
      rating: Random().nextInt(101), // Fake AI rating 0-100
      votes: 0,
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
      ideas.refresh(); // Important for UI to update
      await StorageService.saveIdeas(ideas);
      sortIdeas();
    }
  }

  // Sort the list
  void sortIdeas() {
    if (sortOrder.value == 'rating') {
      ideas.sort((a, b) => b.rating.compareTo(a.rating));
    } else {
      ideas.sort((a, b) => b.votes.compareTo(a.votes));
    }
  }

  void changeSortOrder(String order) {
    sortOrder.value = order;
    sortIdeas();
  }
}

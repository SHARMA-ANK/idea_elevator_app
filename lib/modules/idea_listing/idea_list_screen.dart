import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/modules/idea_submission/idea_controller.dart';

/// A view that displays a list of all submitted startup ideas.
///
/// It is reactive and updates automatically based on the state in [IdeaController].
class IdeaListingScreen extends StatelessWidget {
  // Find the already initialized IdeaController.
  // GetX ensures this is the same instance used by other screens.
  final IdeaController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Ideas'),
        actions: [
          // Use Obx to rebuild the sort icon when the sort order changes.
          Obx(() => Icon(controller.sortOrder.value == 'votes'
              ? Icons.how_to_vote
              : Icons.star_rate)),
          // Sorting menu
          PopupMenuButton<String>(
            onSelected: (value) {
              // Call the controller method to change the sorting logic
              controller.changeSortOrder(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'rating', child: Text('Sort by Rating')),
              PopupMenuItem(value: 'votes', child: Text('Sort by Votes')),
            ],
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body:
          // Obx widget makes the UI reactive to changes in the controller's state.
          // It will automatically rebuild its child whenever the 'ideas' list changes.
          Obx(() {
        if (controller.ideas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lightbulb_outline, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No ideas yet!',
                  style: TextStyle(fontSize: 22, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Text(
                  'Go to the "New Idea" tab to add one.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // If there are ideas, display them in a ListView.
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: controller.ideas.length,
          itemBuilder: (context, index) {
            final idea = controller.ideas[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                // The main visible part of the card
                title: Text(
                  idea.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    idea.tagline,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    idea.rating.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800),
                  ),
                ),
                // Trailing section for actions (voting)
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up_alt_outlined,
                          color: Colors.green),
                      onPressed: () {
                        // Call the controller method to upvote
                        controller.upvoteIdea(idea.id);
                        Get.snackbar(
                          'Voted!',
                          'You upvoted "${idea.name}"',
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(seconds: 2),
                        );
                      },
                    ),
                    // Use Obx to make the vote count reactive
                    Obx(() => Text(
                          controller.ideas[index].votes.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                // Content that appears when the tile is expanded ("Read more")
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      idea.description,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

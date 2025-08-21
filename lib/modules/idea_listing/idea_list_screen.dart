import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/data/models/idea_model.dart';
import 'package:idea_elevator/modules/idea_submission/idea_controller.dart';

class IdeaListingScreen extends StatelessWidget {
  final IdeaController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Ideas'),
        actions: [
          // Sorting menu
          PopupMenuButton<String>(
            tooltip: "Sort Ideas",
            onSelected: controller.changeSortOrder,
            icon: Obx(() => Icon(controller.sortOrder.value == 'votes'
                ? Icons.how_to_vote
                : Icons.star)),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'rating', child: Text('Sort by Rating')),
              PopupMenuItem(value: 'votes', child: Text('Sort by Upvotes')),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.ideas.isEmpty) {
          return _buildEmptyState();
        }
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: controller.ideas.length,
          itemBuilder: (context, index) {
            final idea = controller.ideas[index];
            return _buildIdeaCard(context, idea);
          },
        );
      }),
    );
  }

  // Helper widget for the empty state UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('No ideas yet!',
              style: TextStyle(fontSize: 22, color: Colors.grey[600])),
          SizedBox(height: 8),
          Text('Go to the "New Idea" tab to add one.',
              style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  // Helper widget for building each idea card
  Widget _buildIdeaCard(BuildContext context, Idea idea) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(idea.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child:
              Text(idea.tagline, style: TextStyle(fontStyle: FontStyle.italic)),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Average Rating Display
                Obx(() => _StarRatingDisplay(
                    rating: controller.ideas
                        .firstWhere((i) => i.id == idea.id)
                        .averageRating)),
                SizedBox(height: 12),
                Text(idea.description, textAlign: TextAlign.justify),
                SizedBox(height: 12),
                // Action Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Upvote Button
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up_alt_outlined,
                              color: Colors.green),
                          onPressed: () {
                            controller.upvoteIdea(idea.id);
                            Get.snackbar(
                                'Voted!', 'You upvoted "${idea.name}"');
                          },
                        ),
                        // Reactive vote count
                        Obx(() => Text(
                              controller.ideas
                                  .firstWhere((i) => i.id == idea.id)
                                  .votes
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    // Rate Idea Button
                    TextButton.icon(
                      icon: Icon(Icons.star_border, color: Colors.amber),
                      label: Text('Rate Idea'),
                      onPressed: () => _showRatingDialog(context, idea.id),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context, String ideaId) {
    double currentRating = 3.0; // Default rating
    Get.dialog(
      AlertDialog(
        title: Text('Rate this Idea'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Slide to set your rating (1-5):'),
                SizedBox(height: 10),
                Text(currentRating.toStringAsFixed(1),
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Slider(
                  value: currentRating,
                  min: 1.0,
                  max: 5.0,
                  divisions: 8,
                  label: currentRating.toStringAsFixed(1),
                  onChanged: (double value) {
                    setState(() {
                      currentRating = value;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              controller.rateIdea(ideaId, currentRating);
              Get.back(); // Close the dialog
              Get.snackbar('Thanks!', 'Your rating has been submitted.');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class _StarRatingDisplay extends StatelessWidget {
  final double rating;
  const _StarRatingDisplay({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating - 0.75) {
          return Icon(Icons.star, color: Colors.amber);
        } else if (index < rating - 0.25) {
          return Icon(Icons.star_half, color: Colors.amber);
        } else {
          return Icon(Icons.star_border, color: Colors.amber);
        }
      })
        ..add(SizedBox(width: 8))
        ..add(Text(rating.toStringAsFixed(1),
            style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}

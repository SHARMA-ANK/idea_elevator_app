import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/data/models/idea_model.dart';
import 'package:idea_elevator/modules/leaderboard/leaderboard_controller.dart';

class LeaderboardScreen extends StatelessWidget {
  final LeaderboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🏆 Top 5 Ideas'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Obx(() {
            if (controller.topIdeas.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: controller.topIdeas.length,
              itemBuilder: (context, index) {
                final idea = controller.topIdeas[index];
                return _buildLeaderboardCard(idea, index);
              },
            );
          }),
          ConfettiWidget(
            confettiController: controller.confettiController,
            blastDirection: -pi / 2,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.1,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ],
      ),
    );
  }

  // A helper widget for building the empty state UI
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.query_stats, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No ideas ranked yet!',
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ),
          Text(
            'Vote for ideas to see them here.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // A helper function to get the correct badge based on rank
  Widget _getBadge(int rank) {
    switch (rank) {
      case 0:
        return Text('🥇', style: TextStyle(fontSize: 32));
      case 1:
        return Text('🥈', style: TextStyle(fontSize: 32));
      case 2:
        return Text('🥉', style: TextStyle(fontSize: 32));
      default:
        return Text('#${rank + 1}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600));
    }
  }

  // Builds the custom card for each idea in the leaderboard
  Widget _buildLeaderboardCard(Idea idea, int index) {
    // Define gradients for the top 3 ranks
    final gradients = [
      LinearGradient(colors: [Colors.amber.shade300, Colors.amber.shade600]),
      LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade500]),
      LinearGradient(colors: [Colors.brown.shade300, Colors.brown.shade500]),
    ];

    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          // Apply a gradient for the top 3, otherwise a solid color
          gradient: index < 3 ? gradients[index] : null,
          color: index >= 3 ? Colors.white : null,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            // Left side: Badge
            _getBadge(index),
            const SizedBox(width: 16.0),
            // Middle: Idea details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idea.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      // Use a contrasting color for text on gradients
                      color: index < 3 ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    idea.tagline,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: index < 3 ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Right side: Vote count
            Column(
              children: [
                Text(
                  idea.votes.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: index < 3 ? Colors.white : Colors.blue.shade700,
                  ),
                ),
                Text(
                  'Votes',
                  style: TextStyle(
                    color: index < 3 ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

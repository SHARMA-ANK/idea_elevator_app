import 'package:shared_preferences/shared_preferences.dart';
import 'package:idea_elevator/data/models/idea_model.dart';

/// A service class for handling local data persistence using SharedPreferences.
///
/// This class provides static methods to abstract the logic for saving and
/// retrieving the list of ideas, handling all the JSON conversion.
class StorageService {
  // A constant key for storing and retrieving the list of ideas.
  // Using a constant helps prevent typos.
  static const String _ideasKey = 'startup_ideas';

  /// Saves a list of [Idea] objects to local storage.
  ///
  /// This method converts the list of ideas into a list of JSON strings
  /// before persisting it with SharedPreferences.
  static Future<void> saveIdeas(List<Idea> ideas) async {
    try {
      // Get the instance of SharedPreferences.
      final prefs = await SharedPreferences.getInstance();

      // Convert each Idea object in the list to its JSON string representation.
      final List<String> ideasJson =
          ideas.map((idea) => idea.toJson()).toList();

      // Save the list of JSON strings to local storage.
      await prefs.setStringList(_ideasKey, ideasJson);
    } catch (e) {
      // It's good practice to handle potential errors, e.g., logging.
      print('Failed to save ideas: $e');
    }
  }

  /// Retrieves a list of [Idea] objects from local storage.
  ///
  /// This method fetches the list of JSON strings and converts them back
  /// into a list of [Idea] objects.
  static Future<List<Idea>> getIdeas() async {
    try {
      // Get the instance of SharedPreferences.
      final prefs = await SharedPreferences.getInstance();

      // Retrieve the list of JSON strings from local storage.
      // If no data is found, it defaults to an empty list.
      final List<String> ideasJson = prefs.getStringList(_ideasKey) ?? [];

      // If the list is empty, there's nothing to decode, so return an empty list.
      if (ideasJson.isEmpty) {
        return [];
      }

      // Convert each JSON string back into an Idea object.
      final List<Idea> ideas =
          ideasJson.map((json) => Idea.fromJson(json)).toList();

      return ideas;
    } catch (e) {
      // Handle potential errors during retrieval and decoding.
      print('Failed to get ideas: $e');
      return []; // Return an empty list on failure.
    }
  }
}

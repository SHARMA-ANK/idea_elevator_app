import 'dart:convert';

class Idea {
  String id;
  String name;
  String tagline;
  String description;
  int rating;
  int votes;

  Idea({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    this.votes = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'rating': rating,
      'votes': votes,
    };
  }

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      tagline: map['tagline'] ?? '',
      description: map['description'] ?? '',
      rating: map['rating']?.toInt() ?? 0,
      votes: map['votes']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Idea.fromJson(String source) => Idea.fromMap(json.decode(source));
}

import 'dart:convert';

class Idea {
  String id;
  String name;
  String tagline;
  String description;

  int votes;
  double totalRatingScore;
  int numberOfRatings;
  Idea({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    this.votes = 0,
    this.totalRatingScore = 0.0,
    this.numberOfRatings = 0,
  });
  double get averageRating {
    if (numberOfRatings == 0) {
      return 0.0;
    }
    return totalRatingScore / numberOfRatings;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'votes': votes,
      'totalRatingScore': totalRatingScore,
      'numberOfRatings': numberOfRatings,
    };
  }

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      tagline: map['tagline'] ?? '',
      description: map['description'] ?? '',
      votes: map['votes']?.toInt() ?? 0,
      totalRatingScore: map['totalRatingScore']?.toDouble() ?? 0.0,
      numberOfRatings: map['numberOfRatings']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Idea.fromJson(String source) => Idea.fromMap(json.decode(source));
}

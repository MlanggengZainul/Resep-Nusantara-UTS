/// Model data resep. Nama field JSON memakai snake_case sehingga mudah
/// dipetakan ke respons API pada tahap pengembangan berikutnya.
class Recipe {
  final int id;
  final String name;
  final String category;
  final String emoji;
  final String description;
  final int duration; // menit
  final String difficulty;
  final int servings;
  final double rating;
  final bool isPopular;
  final DateTime addedDate;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.emoji,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.servings,
    required this.rating,
    required this.isPopular,
    required this.addedDate,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      emoji: json['emoji'] as String,
      description: json['description'] as String,
      duration: json['duration'] as int,
      difficulty: json['difficulty'] as String,
      servings: json['servings'] as int,
      rating: (json['rating'] as num).toDouble(),
      isPopular: json['is_popular'] as bool,
      addedDate: DateTime.parse(json['added_date'] as String),
      ingredients: List<String>.from(json['ingredients'] as List),
      steps: List<String>.from(json['steps'] as List),
    );
  }
}

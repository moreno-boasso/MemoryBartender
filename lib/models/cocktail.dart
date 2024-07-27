class Cocktail {
  final String id;
  final String name;
  final String imageUrl;
  final bool isAlcoholic;
  final List<Map<String, String>> ingredients;
  final String instructions;

  Cocktail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isAlcoholic,
    required this.ingredients,
    required this.instructions,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    // Converti ogni elemento della lista degli ingredienti in una mappa
    var ingredientsFromJson = (json['ingredients'] as List)
        .map((item) => Map<String, String>.from(item))
        .toList();

    return Cocktail(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      isAlcoholic: json['isAlcoholic'],
      ingredients: ingredientsFromJson,
      instructions: json['instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    var ingredientsToJson = ingredients
        .map((item) => Map<String, String>.from(item))
        .toList();

    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'isAlcoholic': isAlcoholic,
      'ingredients': ingredientsToJson,
      'instructions': instructions,
    };
  }
}

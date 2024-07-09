class Cocktail {
  final String id;
  final String name;
  final String imageUrl;
  final bool isAlcoholic;
  final String glassType;
  final List<Map<String, String>> ingredients;
  final String instructions; // Nuovo campo per le istruzioni di preparazione

  Cocktail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isAlcoholic,
    required this.glassType,
    required this.ingredients,
    required this.instructions, // Aggiunto al costruttore
  });
}

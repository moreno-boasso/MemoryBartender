class Cocktail {
  final String name;
  final String imageUrl;
  final bool isAlcoholic;
  final String instructions;
  final List<String> ingredients; // Lista degli ingredienti
  final List<String> measures;   // Lista delle misure degli ingredienti
  final String glass;            // Tipo di bicchiere

  Cocktail({
    required this.name,
    required this.imageUrl,
    required this.isAlcoholic,
    required this.instructions,
    required this.ingredients,
    required this.measures,
    required this.glass,
  });

  // Factory method per creare un oggetto Cocktail da un json
  factory Cocktail.fromJson(Map<String, dynamic> json) {
    // Estrarre gli ingredienti, le misure e il tipo di bicchiere dall'oggetto json
    List<String> ingredients = [];
    List<String> measures = [];

    // Estrai fino a un massimo di 15 ingredienti
    for (int i = 1; i <= 15; i++) {
      if (json['strIngredient$i'] != null && json['strIngredient$i'].trim().isNotEmpty) {
        ingredients.add(json['strIngredient$i']);
        measures.add(json['strMeasure$i'] ?? ''); // Aggiungi la misura o stringa vuota se mancante
      }
    }

    return Cocktail(
      name: json['strDrink'],
      imageUrl: json['strDrinkThumb'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
      instructions: json['strInstructions'],
      ingredients: ingredients,
      measures: measures,
      glass: json['strGlass'], // Aggiungi il tipo di bicchiere
    );
  }
}

class Cocktail {
  final String name;
  final String imageUrl;
  final bool isAlcoholic;
  final String instructions;
  final List<String> ingredients; // Lista degli ingredienti
  final List<String> measures;   // Lista delle misure degli ingredienti

  Cocktail({
    required this.name,
    required this.imageUrl,
    required this.isAlcoholic,
    required this.instructions,
    required this.ingredients,
    required this.measures,
  });

  // Factory method per creare un oggetto Cocktail da un json
  factory Cocktail.fromJson(Map<String, dynamic> json) {
    // Mappa per tradurre e convertire le unità di misura
    Map<String, String> unitTranslations = {
      'oz': 'cl',   // Converti oz in cl
      'tsp': 'cucchiaino',
      'dash': 'pizzico',
      //'dashes' : 'pizzico',
      'cube': 'cubetto di',
      'splash': 'splash di',
    };

    // Estrarre gli ingredienti e le misure dall'oggetto json
    List<String> ingredients = [];
    List<String> measures = [];

    // Estrai fino a un massimo di 15 ingredienti
    for (int i = 1; i <= 15; i++) {
      if (json['strIngredient$i'] != null && json['strIngredient$i'].trim().isNotEmpty) {
        ingredients.add(json['strIngredient$i']);
        String measure = json['strMeasure$i'] ?? '';

        // Controlla se la misura contiene un numero seguito dall'unità di misura
        RegExp regex = RegExp(r'^(\d+(\.\d+)?)\s*(\w+)$');
        if (regex.hasMatch(measure.trim())) {
          // Estrarre il numero e l'unità di misura
          Match match = regex.firstMatch(measure.trim())!;
          double value = double.parse(match.group(1)!);
          String unit = match.group(3)!;

          // Converti solo se l'unità di misura è "oz"
          if (unit == 'oz') {
            double clValue = value * 2.95735; // Conversione da oz a cl
            measures.add(clValue.toStringAsFixed(2) + ' cl');
          } else {
            measures.add(unitTranslations[unit] ?? measure); // Usa la traduzione, se disponibile
          }
        } else {
          measures.add(unitTranslations[measure.trim()] ?? measure); // Usa la traduzione, se disponibile
        }
      }
    }

    return Cocktail(
      name: json['strDrink'],
      imageUrl: json['strDrinkThumb'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
      instructions: json['strInstructions'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}

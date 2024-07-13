import 'package:flutter/material.dart';
import '../components/cocktail_detail_screen/image_detail.dart';
import '../components/cocktail_detail_screen/cocktail_title.dart';
import '../components/cocktail_detail_screen/instructions_detail.dart';
import '../components/cocktail_detail_screen/ingredients_detail.dart';
import '../models/cocktail.dart';
import '../services/cocktail_service.dart';

enum ConversionUnit {
  Ounce,
  Shot,
  Dash,
}

class CocktailDetailsPage extends StatefulWidget {
  final String cocktailId;

  const CocktailDetailsPage({Key? key, required this.cocktailId}) : super(key: key);

  @override
  _CocktailDetailsPageState createState() => _CocktailDetailsPageState();
}

class _CocktailDetailsPageState extends State<CocktailDetailsPage> {
  List<int> conversionsToShow = [1, 2, 3]; // Inizialmente mostrerà le prime 3 conversioni
  ConversionUnit _selectedUnit = ConversionUnit.Ounce; // Inizialmente selezionato Ounce

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cocktail>(
      future: CocktailService().getCocktailDetails(widget.cocktailId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data'));
        }

        final cocktail = snapshot.data!;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CocktailImageHeader(cocktail: cocktail, context: context),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CocktailTitle(cocktail: cocktail),
                      const SizedBox(height: 30),

                      // Ingredienti
                      IngredientsDetail(ingredients: cocktail.ingredients),
                      const SizedBox(height: 30),

                      // Preparazione
                      CocktailInstructions(instructions: cocktail.instructions),
                      const SizedBox(height: 30),

                      // Container per la conversione Unità con ombra
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Conversioni:', // Titolo delle conversioni
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildConversionButton(ConversionUnit.Ounce, Icons.local_drink, 'Oz'),
                                _buildConversionButton(ConversionUnit.Shot, Icons.shutter_speed, 'Shots'),
                                _buildConversionButton(ConversionUnit.Dash, Icons.flash_on, 'Dash'),
                              ],
                            ),
                            SizedBox(height: 10),

                            SizedBox(height: 10),
                            ..._buildConversionRows(cocktail, _selectedUnit),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  _loadMoreConversions(cocktail);
                                },
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildConversionRows(Cocktail cocktail, ConversionUnit unit) {
    List<Widget> rows = [];

    for (int i in conversionsToShow) {
      double value = i.toDouble();
      String label = _getUnitLabel(unit);

      double convertedValue = (unit == ConversionUnit.Dash) ? value : _convertToCl(value, unit);

      String valueText = '${value.toStringAsFixed(0)} ${label}';
      String convertedText = (unit == ConversionUnit.Dash) ? '${value.toStringAsFixed(0)} Pizzico' : '≈ ${convertedValue.toStringAsFixed(0)} cl';

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                valueText,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                convertedText,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      );
    }

    return rows;
  }


  double _convertToCl(double value, ConversionUnit unit) {
    switch (unit) {
      case ConversionUnit.Ounce:
        return value * 2.95735;
      case ConversionUnit.Shot:
      // Implementa la conversione da shot a cl
        return value * 3; // Esempio di conversione
      case ConversionUnit.Dash:
        return value;
      default:
        return 0.0;
    }
  }


  String _getUnitLabel(ConversionUnit unit) {
    switch (unit) {
      case ConversionUnit.Ounce:
        return 'oz';
      case ConversionUnit.Shot:
        return 'shots';
      case ConversionUnit.Dash:
        return 'dash';
      default:
        return '';
    }
  }

  Widget _buildConversionButton(ConversionUnit unit, IconData icon, String label) {
    bool isSelected = (_selectedUnit == unit);

    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {
            setState(() {
              _selectedUnit = unit;
            });
          },
          tooltip: 'Converti in $label',
          color: isSelected ? Colors.blue : Colors.black, // Colora l'icona se selezionata
        ),
        Text(
          label, // Testo della descrizione
          style: TextStyle(fontSize: 12.0), // Puoi regolare il font size secondo necessità
        ),
      ],
    );
  }

  void _loadMoreConversions(Cocktail cocktail) {
    setState(() {
      conversionsToShow.addAll([conversionsToShow.length + 1, conversionsToShow.length + 2, conversionsToShow.length + 3]);
    });
  }
}

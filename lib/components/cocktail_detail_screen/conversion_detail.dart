import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';

enum ConversionUnit {
  Ounce,
  Shot,
}

class ConversionSection extends StatefulWidget {
  final Cocktail cocktail;

  const ConversionSection({super.key, required this.cocktail});

  @override
  _ConversionSectionState createState() => _ConversionSectionState();
}

class _ConversionSectionState extends State<ConversionSection> {
  List<int> conversionsToShow = [1, 2, 3];
  ConversionUnit _selectedUnit = ConversionUnit.Ounce;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: MemoColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: MemoColors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Conversioni:',
            style: MemoText.subtitleDetail,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildConversionButton(ConversionUnit.Ounce, Icons.local_drink, 'Oz'),
              _buildConversionButton(ConversionUnit.Shot, Icons.water_drop, 'Shots'),
            ],
          ),

          const SizedBox(height: 10),

          // Righe di conversione
          ..._buildConversionRows(widget.cocktail, _selectedUnit),

          Center(
            child: TextButton(
              onPressed: () {
                _loadMoreConversions(widget.cocktail);
              },
              child: const Icon(Icons.keyboard_arrow_down,color: MemoColors.black,),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildConversionRows(Cocktail cocktail, ConversionUnit unit) {
    List<Widget> rows = [];

    for (int i in conversionsToShow) {
      double value = i.toDouble();
      String label = _getUnitLabel(unit);

      double convertedValue = _convertToCl(value, unit);

      String valueText = '${value.toStringAsFixed(0)} $label';
      String convertedText = '≈ ${convertedValue.toStringAsFixed(0)} cl';

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                valueText,
                style: MemoText.conversionNumbers
              ),
              const SizedBox(width: 5,),
              Text(
                convertedText,
                  style: MemoText.conversionNumbers
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
        return value *  2.95735;
      case ConversionUnit.Shot:
        return value * 5;
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
      default:
        return '';
    }
  }

  Widget _buildConversionButton(ConversionUnit unit, IconData icon, String label) {
    bool isSelected = (_selectedUnit == unit);

    return Column(
      children: [
        IconButton(
          icon: Icon(icon,color: isSelected ?   MemoColors.black : MemoColors.black.withOpacity(0.4)),
          onPressed: () {
            setState(() {
              _selectedUnit = unit;
            });
          },
          tooltip: 'Converti in $label',
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14.0,color: isSelected ? MemoColors.black : MemoColors.black.withOpacity(0.4)),
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

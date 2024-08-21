import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';

class CocktailInstructions extends StatefulWidget {
  final String instructions;

  const CocktailInstructions({super.key, required this.instructions});

  @override
  _CocktailInstructionsState createState() => _CocktailInstructionsState();
}

class _CocktailInstructionsState extends State<CocktailInstructions> {
  String translatedText = '';
  bool isTranslated = false;
  bool isLoading = false;

  final translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    // Optionally initiate translation on widget load
    // translateInstructions();
  }

  Future<void> translateInstructions() async {
    setState(() {
      isLoading = true;
    });

    try {
      final translation = await translator.translate(widget.instructions, to: 'it');
      setState(() {
        translatedText = translation.text;
        isTranslated = true;
      });
    } catch (e) {
      // Handle translation error
      if (kDebugMode) {
        print('Translation error: $e');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleTranslation() {
    if (isTranslated) {
      setState(() {
        isTranslated = false;
      });
    } else {
      translateInstructions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Istruzioni:',
          style: MemoText.subtitleDetail,
        ),
        const SizedBox(height: 7),
        Text(
          isTranslated ? translatedText : widget.instructions,
          style: MemoText.instructionsText,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: isLoading ? null : toggleTranslation,
              style: TextButton.styleFrom(
                foregroundColor: MemoColors.black.withOpacity(0.4),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(MemoColors.brownie),
              )
                  : Text(
                isTranslated ? 'Mostra originale' : 'Traduci',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

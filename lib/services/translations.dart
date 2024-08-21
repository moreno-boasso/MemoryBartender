import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translateInstructions(String text, String targetLang) async {
    try {
      // Trim spaces from the input text
      text = text.trim();

      // Check if the text is not empty
      if (text.isEmpty) {
        return 'No instructions provided.';
      }

      // Perform the translation
      var translation = await _translator.translate(text, to: targetLang);
      return translation.text;

    } catch (e) {
      // Handle any errors that occur during translation
      return 'Translation failed: ${e.toString()}';
    }
  }
}

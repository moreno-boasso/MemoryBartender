import 'package:translator/translator.dart';

Future<String> translateInstructions(String text, String targetLang) async {
  final translator = GoogleTranslator();
  var translation = await translator.translate(text, to: targetLang);
  return translation.text;
}

import 'package:translate_now/layers/domain/enum/translation_language.dart';

abstract class TranslationRepository {
  Future<String> translate(String text, TranslationLanguage from, TranslationLanguage to);
  const TranslationRepository();
}

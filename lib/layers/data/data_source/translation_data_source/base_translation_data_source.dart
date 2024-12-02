import 'package:translate_now/layers/domain/enum/translation_language.dart';

abstract class BaseTranslationDataSource {
  Future<String> translate(
    String text,
    TranslationLanguage to,
  );

  Future<bool> init();
  Future<bool> dispose();
}

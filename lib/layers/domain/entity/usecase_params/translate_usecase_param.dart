import 'package:translate_now/layers/domain/enum/translation_language.dart';

class TranslateUsecaseParam {
  final String text;
  final TranslationLanguage from;
  final TranslationLanguage to;

  TranslateUsecaseParam({
    required this.text,
    required this.from,
    required this.to,
  });

  factory TranslateUsecaseParam.toHindi(String text) {
    return TranslateUsecaseParam(
      text: text,
      from: TranslationLanguage.english,
      to: TranslationLanguage.hindi,
    );
  }
}

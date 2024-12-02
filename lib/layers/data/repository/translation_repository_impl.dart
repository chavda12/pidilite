import 'package:translate_now/layers/data/data_source/translation_data_source/base_translation_data_source.dart';
import 'package:translate_now/layers/di/setup_locators.dart';
import 'package:translate_now/layers/domain/enum/translation_language.dart';
import 'package:translate_now/layers/domain/repository/translation_repository.dart';

class TranslationRepositoryImpl extends TranslationRepository {
  const TranslationRepositoryImpl();

  @override
  Future<String> translate(
    String text,
    TranslationLanguage from,
    TranslationLanguage to,
  ) {
    final dataSource = _retriveTranslationSource(from, to);
    return dataSource.translate(text, to);
  }

  BaseTranslationDataSource _retriveTranslationSource(
    TranslationLanguage from,
    TranslationLanguage to,
  ) {
    return switch (to) {
      // we can add more case as per requirement
      TranslationLanguage.hindi => di<BaseTranslationDataSource>(
          instanceName: to.name,
        ),
      _ => di<BaseTranslationDataSource>(
          instanceName: TranslationLanguage.hindi.name,
        )
    };
  }
}

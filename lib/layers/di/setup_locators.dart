import 'package:get_it/get_it.dart';
import 'package:translate_now/layers/data/data_source/tnc_data_source/base_tnc_data_source.dart';
import 'package:translate_now/layers/data/data_source/tnc_data_source/local/tnc_local_data_source.dart';
import 'package:translate_now/layers/data/data_source/translation_data_source/base_translation_data_source.dart';
import 'package:translate_now/layers/data/data_source/translation_data_source/local/hindi_translation_data_source.dart';
import 'package:translate_now/layers/data/repository/tnc_repository_impl.dart';
import 'package:translate_now/layers/data/repository/translation_repository_impl.dart';
import 'package:translate_now/layers/data/service/speech_to_text_service_impl.dart';
import 'package:translate_now/layers/domain/enum/translation_language.dart';
import 'package:translate_now/layers/domain/repository/tnc_repository.dart';
import 'package:translate_now/layers/domain/repository/translation_repository.dart';
import 'package:translate_now/layers/domain/service/speech_to_text_service.dart';
import 'package:translate_now/layers/domain/usecase/tnc_usecase/tnc_usecase.dart';
import 'package:translate_now/layers/domain/usecase/translate_usecase/translate_usecase.dart';

final di = GetIt.I;
Future<void> setupLocators() async {
  di.registerLazySingleton<BaseTncDataSource>(() => TncLocalDataSource());

  di.registerLazySingleton<TncRepository>(
    () => TncRepositoryImpl(tncDataSource: di<BaseTncDataSource>()),
  );

  di.registerLazySingleton<TncUseCase>(
    () => TncUseCase(repository: di<TncRepository>()),
  );

  di.registerLazySingleton<BaseTranslationDataSource>(
    () => HindiTranslationDataSource(),
    dispose: (param) => param.dispose(),
    instanceName: TranslationLanguage.hindi.name,
  );

  di.registerLazySingleton<TranslationRepository>(
    () => const TranslationRepositoryImpl(),
  );

  di.registerLazySingleton(
    () => TranslateUsecase(
      di<TranslationRepository>(),
    ),
  );
  di.registerLazySingleton<SpeechToTextService>(
    () => STTImpl(),
  );
}

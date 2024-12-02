import 'package:translate_now/layers/domain/entity/usecase_params/translate_usecase_param.dart';
import 'package:translate_now/layers/domain/repository/translation_repository.dart';
import 'package:translate_now/layers/domain/usecase/base_usecase.dart';

class TranslateUsecase extends BaseUseCase<String, TranslateUsecaseParam> {
  final TranslationRepository _translationRepository;
  const TranslateUsecase(this._translationRepository);

  @override
  Future<String> call({required TranslateUsecaseParam params}) {
    return _translationRepository.translate(
      params.text,
      params.from,
      params.to,
    );
  }
}

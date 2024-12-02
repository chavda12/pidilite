import 'package:translate_now/layers/domain/entity/paginated_data_entity.dart';
import 'package:translate_now/layers/domain/entity/tnc_entity.dart';
import 'package:translate_now/layers/domain/entity/usecase_params/tnc_usecase_param.dart';
import 'package:translate_now/layers/domain/repository/tnc_repository.dart';
import 'package:translate_now/layers/domain/usecase/base_usecase.dart';

class TncUseCase
    extends BaseUseCase<PaginatedDataEntity<TncEntity>, TncUsecaseParam> {
  final TncRepository _repository;

  const TncUseCase({required TncRepository repository})
      : _repository = repository;

  @override
  Future<PaginatedDataEntity<TncEntity>> call({
    required TncUsecaseParam params,
  }) async {
    if (params.shouldFetchAll) {
      return _repository.getAllTnc();
    }

    return _repository.getTncPaginated(params as PaginatedTncUsecaseParam);
  }
}

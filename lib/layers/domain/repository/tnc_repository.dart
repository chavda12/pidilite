import 'package:translate_now/layers/domain/entity/paginated_data_entity.dart';
import 'package:translate_now/layers/domain/entity/tnc_entity.dart';
import 'package:translate_now/layers/domain/entity/usecase_params/tnc_usecase_param.dart';

abstract class TncRepository {
  Future<PaginatedDataEntity<TncEntity>> getAllTnc();

  Future<PaginatedDataEntity<TncEntity>> getTncPaginated(PaginatedTncUsecaseParam params);

  const TncRepository();
}

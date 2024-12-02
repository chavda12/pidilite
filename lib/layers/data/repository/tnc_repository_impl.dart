import 'package:translate_now/layers/data/data_source/tnc_data_source/base_tnc_data_source.dart';
import 'package:translate_now/layers/data/model/pagineted_data.dart';
import 'package:translate_now/layers/data/model/tnc_model.dart';
import 'package:translate_now/layers/domain/entity/tnc_entity.dart';
import 'package:translate_now/layers/domain/entity/usecase_params/tnc_usecase_param.dart';
import 'package:translate_now/layers/domain/repository/tnc_repository.dart';

class TncRepositoryImpl implements TncRepository {
  final BaseTncDataSource tncDataSource;

  const TncRepositoryImpl({required this.tncDataSource});

  @override
  Future<PaginatedData<TncModel>> getAllTnc() async {
    return tncDataSource.getAllTnc();
  }

  @override
  Future<PaginatedData<TncEntity>> getTncPaginated(PaginatedTncUsecaseParam params) {
    return tncDataSource.getTncPaginated(
      params.nextPage,
      params.limit,
      params.offset,
    );
  }
}

import 'package:translate_now/layers/data/model/pagineted_data.dart';
import 'package:translate_now/layers/data/model/tnc_model.dart';

abstract class BaseTncDataSource {
  Future<PaginatedData<TncModel>> getAllTnc();

  Future<PaginatedData<TncModel>> getTncPaginated(
    int page,
    int limit, [
    int offset = 0,
  ]);

  const BaseTncDataSource();
}

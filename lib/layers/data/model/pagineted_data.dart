import 'package:translate_now/layers/domain/entity/paginated_data_entity.dart';

class PaginatedData<T> extends PaginatedDataEntity<T> {
  const PaginatedData(
    super._data, {
    required super.limit,
    required super.totalPage,
    required super.currentPage,
    required super.totalData,
  });
}

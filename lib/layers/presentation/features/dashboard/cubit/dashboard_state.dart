import 'package:translate_now/layers/domain/entity/paginated_data_entity.dart';
import 'package:translate_now/layers/domain/entity/tnc_entity.dart';
import 'package:translate_now/layers/presentation/cubits/base_state.dart';

class DashboardState extends BaseState {
  final PaginatedDataEntity<TncEntity> tncList;

  DashboardState({
    this.tncList = const PaginatedDataEntity.empty(limit: 60),
    super.isLoading = false,
  });

  DashboardState copyWith({
    PaginatedDataEntity<TncEntity>? tncList,
    bool? isLoading,
  }) {
    return DashboardState(
      tncList: tncList ?? this.tncList,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  DashboardState startLoading() => copyWith(isLoading: true);

  @override
  DashboardState stopLoading() => copyWith(isLoading: false);
}

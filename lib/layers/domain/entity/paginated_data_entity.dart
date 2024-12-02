import 'dart:collection';

class PaginatedDataEntity<T> extends ListBase<T> {
  final List<T> _data;
  final int limit;
  final int totalPage;
  final int currentPage;
  final int totalData;

  const PaginatedDataEntity(
    this._data, {
    required this.limit,
    required this.totalPage,
    required this.currentPage,
    required this.totalData,
  });

  const PaginatedDataEntity.empty({
    this.limit = 0,
  })  : _data = const [],
        currentPage = 0,
        totalData = 0,
        totalPage = 0;

  bool get isAtLastPage => currentPage == totalPage-1 && isNotEmpty;

  int get nextPage {
    if (isEmpty) return 0;
    if (currentPage >= totalPage-1) return totalPage-1;
    return currentPage + 1;
  }

  PaginatedDataEntity<T> copyWith({
    List<T>? data,
    int? limit,
    int? totalPage,
    int? currentPage,
    int? totalData,
  }) {
    return PaginatedDataEntity(
      data ?? this._data,
      limit: limit ?? this.limit,
      totalPage: totalPage ?? this.totalPage,
      currentPage: currentPage ?? this.currentPage,
      totalData: totalData ?? this.totalData,
    );
  }

  PaginatedDataEntity<T> addNewData(PaginatedDataEntity<T> newData) {
    return PaginatedDataEntity(
      this + newData,
      limit: newData.limit,
      totalPage: newData.totalPage,
      currentPage: newData.currentPage,
      totalData: newData.totalData,
    );
  }

  factory PaginatedDataEntity.withAllData(List<T> data) {
    return PaginatedDataEntity(
      data,
      limit: data.length,
      totalPage: 1,
      currentPage: 1,
      totalData: data.length,
    );
  }

  @override
  int get length => _data.length;

  @override
  T operator [](int index) {
    if (index >= _data.length) {
      throw RangeError('Index out of range');
    }
    return _data[index];
  }

  @override
  void operator []=(int index, T value) {
    if (index >= _data.length) {
      throw RangeError('Index out of range');
    }
    _data[index] = value;
  }

  @override
  set length(int newLength) {
    _data.length = newLength;
  }
}

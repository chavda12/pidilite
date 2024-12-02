import 'dart:math';

import 'package:translate_now/layers/data/constants/tnc_data.dart';
import 'package:translate_now/layers/data/data_source/tnc_data_source/base_tnc_data_source.dart';
import 'package:translate_now/layers/data/model/pagineted_data.dart';
import 'package:translate_now/layers/data/model/tnc_model.dart';

class TncLocalDataSource implements BaseTncDataSource {
  late final List<TncModel> _allData;
  TncLocalDataSource() {
    _allData = tncData.map((e) => TncModel.fromJson(e)).toList();
  }

  @override
  Future<PaginatedData<TncModel>> getAllTnc() {
    final data = PaginatedData<TncModel>(
      _allData,
      limit: _allData.length,
      totalPage: 1,
      currentPage: 1,
      totalData: _allData.length,
    );
    return Future.delayed(const Duration(seconds: 2), () => data);
  }

  @override
  Future<PaginatedData<TncModel>> getTncPaginated(
    int page,
    int limit, [
    int offset = 0,
  ]) {
    int startIndex = page * limit;
    startIndex = min(startIndex, _allData.length);

    int lastIndex = startIndex + limit;
    lastIndex = min(lastIndex, _allData.length);

    final data = _allData.sublist(startIndex, lastIndex);

    final paginatedData = PaginatedData<TncModel>(
      data,
      limit: limit,
      totalPage: (_allData.length / limit).ceil(),
      currentPage: page,
      totalData: _allData.length,
    );

    return Future.delayed(const Duration(seconds: 2), () => paginatedData);
  }
}

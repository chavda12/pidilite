abstract class TncUsecaseParam {
  final int limit;
  final int offset;
  final int nextPage;
  TncUsecaseParam({
    required this.limit,
    required this.offset,
    required this.nextPage,
  });


  bool get shouldFetchAll => limit == 0 && offset == 0 && nextPage == 0;

}

class PaginatedTncUsecaseParam extends TncUsecaseParam {
  PaginatedTncUsecaseParam({
    required super.nextPage,
    required super.limit,
    super.offset = 0,
  });
}

class AllTncUsecaseParam extends TncUsecaseParam {
  AllTncUsecaseParam({
    super.limit = 0,
    super.offset = 0,
    super.nextPage = 0,
  });
}

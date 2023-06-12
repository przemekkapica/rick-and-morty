import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_info.f.freezed.dart';

@freezed
class PaginationInfo with _$PaginationInfo {
  factory PaginationInfo({
    required int currentPage,
    required int totalPages,
    required bool hasPrevious,
    required bool hasNext,
  }) = _PaginationInfo;

  factory PaginationInfo.initial() {
    return PaginationInfo(
      currentPage: 1,
      totalPages: 1,
      hasPrevious: false,
      hasNext: false,
    );
  }
}

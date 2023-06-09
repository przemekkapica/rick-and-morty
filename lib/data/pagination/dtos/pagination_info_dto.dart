import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_info_dto.g.dart';

@JsonSerializable()
class PaginationInfoDTO {
  PaginationInfoDTO({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory PaginationInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoDTOFromJson(json);

  final int count;
  final int pages;
  final String? next;
  final String? prev;
}

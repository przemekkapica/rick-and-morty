import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_characters_info_dto.g.dart';

@JsonSerializable()
class GetCharactersInfoDTO {
  GetCharactersInfoDTO({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory GetCharactersInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$GetCharactersInfoDTOFromJson(json);

  final int count;
  final int pages;
  final String? next;
  final String? prev;
}

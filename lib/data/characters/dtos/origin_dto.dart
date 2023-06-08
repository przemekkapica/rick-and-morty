import 'package:freezed_annotation/freezed_annotation.dart';

part 'origin_dto.g.dart';

@JsonSerializable()
class OriginDTO {
  OriginDTO({
    required this.name,
    required this.url,
  });

  factory OriginDTO.fromJson(Map<String, dynamic> json) =>
      _$OriginDTOFromJson(json);

  final String name;
  final String url;
}

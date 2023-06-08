import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDTO {
  LocationDTO({
    required this.name,
    required this.url,
  });

  factory LocationDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationDTOFromJson(json);

  final String name;
  final String url;
}

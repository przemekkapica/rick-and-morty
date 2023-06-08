import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/data/characters/dtos/location_dto.dart';
import 'package:rick_and_morty/data/characters/dtos/origin_dto.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDTO {
  CharacterDTO({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterDTO.fromJson(Map<String, dynamic> json) =>
      _$CharacterDTOFromJson(json);

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginDTO origin;
  final LocationDTO location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;
}

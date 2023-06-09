import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/data/characters/dtos/character_dto.dart';
import 'package:rick_and_morty/data/pagination/dtos/pagination_info_dto.dart';

part 'get_characters_dto.g.dart';

@JsonSerializable()
class GetCharactersDTO {
  GetCharactersDTO({
    required this.info,
    required this.results,
  });

  factory GetCharactersDTO.fromJson(Map<String, dynamic> json) =>
      _$GetCharactersDTOFromJson(json);

  final PaginationInfoDTO info;
  final List<CharacterDTO> results;
}

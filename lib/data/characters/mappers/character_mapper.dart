import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/characters/dtos/character_dto.dart';
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/mappers/from_dto_mapper.dart';

@injectable
class CharacterMapper extends DataMapper<CharacterDTO, Character> {
  CharacterMapper(this._statusMapper);

  final StatusMapper _statusMapper;

  @override
  Character call(CharacterDTO dto) {
    return Character(
      name: dto.name,
      status: _statusMapper(dto.status),
      image: Uri.parse(dto.image),
      species: dto.species,
    );
  }
}

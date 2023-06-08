import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/characters/dtos/character_dto.dart';
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart';
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart';
import 'package:rick_and_morty/domain/characters/model/character_details.f.dart';
import 'package:rick_and_morty/domain/mappers/from_dto_mapper.dart';

@injectable
class CharacterDetailsMapper
    extends DataMapper<CharacterDTO, CharacterDetails> {
  CharacterDetailsMapper(
    this._statusMapper,
    this._genderMapper,
  );

  final StatusMapper _statusMapper;
  final GenderMapper _genderMapper;

  @override
  CharacterDetails call(CharacterDTO dto) {
    return CharacterDetails(
      name: dto.name,
      status: _statusMapper(dto.status),
      image: Uri.parse(dto.image),
      species: dto.species,
      created: dto.created,
      gender: _genderMapper(dto.gender),
      location: dto.location.name,
      origin: dto.origin.name,
      type: dto.type,
    );
  }
}

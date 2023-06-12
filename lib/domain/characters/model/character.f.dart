import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';

part 'character.f.freezed.dart';
part 'character.f.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class Character with _$Character implements BaseCharacter {
  const Character._();

  const factory Character({
    // ignore: invalid_annotation_target
    @Index(type: IndexType.value) required int id,
    required String name,
    // ignore: invalid_annotation_target
    @enumerated required Status status,
    required String image,
    required String species,
    required String type,
    // ignore: invalid_annotation_target
    @enumerated required Gender gender,
    required String origin,
    required String location,
    required String created,
    required bool isFavorite,
  }) = _Character;

  factory Character.fromBaseCharacter(
    BaseCharacter character,
    bool isFavorite,
  ) {
    return Character(
      id: character.id,
      name: character.name,
      status: character.status,
      image: character.image,
      species: character.species,
      type: character.type,
      gender: character.gender,
      origin: character.origin,
      location: character.location,
      created: character.created,
      isFavorite: isFavorite,
    );
  }

  @override
  // ignore: recursive_getters
  Id get id => id;
}

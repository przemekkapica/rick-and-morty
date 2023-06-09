import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';

part 'character.f.freezed.dart';
part 'character.f.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class Character with _$Character {
  const Character._();

  const factory Character({
    required int id,
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
  }) = _CharacterDetails;

  @override
  // ignore: recursive_getters
  Id get id => id;
}

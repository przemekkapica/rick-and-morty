import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';

part 'character.f.freezed.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    required Status status,
    required Uri image,
    required String species,
    required String type,
    required Gender gender,
    required String origin,
    required String location,
    required String created,
  }) = _CharacterDetails;
}

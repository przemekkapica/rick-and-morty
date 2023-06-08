import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';

part 'character.f.freezed.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String name,
    required Status status,
    required Uri image,
    required String species,
  }) = _Character;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';

part 'characters_filter.f.freezed.dart';

@freezed
class CharactersFilter with _$CharactersFilter {
  const factory CharactersFilter({
    String? name,
    Status? status,
    String? species,
    Gender? gender,
  }) = _CharactersFilter;
}

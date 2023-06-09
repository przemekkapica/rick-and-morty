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

extension CharactersFilterNullableExtension on CharactersFilter? {
  bool get isFilterEnabled {
    if (this == null) {
      return false;
    } else {
      if ((this!.name == null || this!.name == '') &&
          this!.status == null &&
          (this!.species == null || this!.species == '') &&
          this!.gender == null) {
        return false;
      }

      return true;
    }
  }
}

extension CharactersFilterExtension on CharactersFilter {
  CharactersFilter get normalize {
    String? newName;
    String? newSpecies;
    if (name != null && name!.isEmpty) {
      newName = null;
    } else {
      newName = name;
    }
    if (species != null && species!.isEmpty) {
      newSpecies = null;
    } else {
      newSpecies = species;
    }

    return CharactersFilter(
      name: newName,
      status: status,
      species: newSpecies,
      gender: gender,
    );
  }
}

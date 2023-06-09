import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';

part 'filter_characters_store.g.dart';

@injectable
class FilterCharactersStore extends _FilterCharactersStore
    with _$FilterCharactersStore {}

abstract class _FilterCharactersStore with Store {
  @readonly
  String? _name;

  @readonly
  String? _species;

  @readonly
  Status? _status;

  @readonly
  Gender? _gender;

  @action
  void setName(String value) => _name = value;

  @action
  void setSpecies(String value) => _species = value;

  @action
  void setStatus(Status value, bool selected) {
    if (selected) {
      _status = value;
    } else {
      _status = null;
    }
  }

  @action
  void setGender(Gender value, bool selected) {
    if (selected) {
      _gender = value;
    } else {
      _gender = null;
    }
  }

  @computed
  CharactersFilter get filter {
    return CharactersFilter(
      name: _name,
      status: _status,
      species: _species,
      gender: _gender,
    );
  }
}

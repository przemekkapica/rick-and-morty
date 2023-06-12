import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

@injectable
class UpdateLocalCharacter {
  UpdateLocalCharacter(this._repository);

  final CharactersRepository _repository;

  Future<void> call(Character character) async {
    return await _repository.updateLocalCharacter(character);
  }
}

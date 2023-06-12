import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

@injectable
class SaveCharactersToDatabase {
  SaveCharactersToDatabase(this._repository);

  final CharactersRepository _repository;

  Future<void> call(List<Character> characters) async {
    for (final character in characters) {
      await _repository.saveToDatabase(character);
    }
  }
}

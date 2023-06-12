import 'package:rick_and_morty/domain/characters/model/character.f.dart';

abstract class LocalCharactersDataSource {
  Future<List<Character>> getCharacters();

  Future<void> addCharacter(Character character);

  Future<bool> isFavorite(int id);

  Future<void> removeCharacter(int id);

  Future<bool> checkIfCharacterExists(int id);

  Future<void> updateCharacter(Character character);
}

import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

abstract class LocalCharactersDataSource {
  Future<List<Character>> getCharacters();

  Future<void> addCharacter(Character character);

  Future<void> removeCharacter(int id);

  Future<bool> checkIfCharacterExists(int id);
}

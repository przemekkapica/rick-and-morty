import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';

abstract class CharactersRepository {
  Future<CharactersPage> getCharacters(int? page, CharactersFilter filter);

  Future<bool> checkIfLocalCharacterExists(int id);

  Future<bool> isFavoriteCharacter(int id);

  Future<List<Character>> getLocalCharacters();

  Future<void> saveToDatabase(Character character);

  Future<void> updateLocalCharacter(Character character);
}

import 'package:rick_and_morty/domain/characters/model/character.f.dart';

abstract class CharactersRepository {
  Future<List<Character>> getCharacters();
}

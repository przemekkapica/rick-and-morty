import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';

abstract class CharactersRepository {
  Future<List<Character>> getCharacters(int? page, CharactersFilter filter);
}

import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';

abstract class CharactersRepository {
  Future<CharactersPage> getCharacters(int? page, CharactersFilter filter);
}

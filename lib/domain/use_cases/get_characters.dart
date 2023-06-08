import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';

@injectable
class GetCharacters {
  GetCharacters(this._repository);

  final CharactersRepository _repository;

  Future<List<Character>> call(int page, CharactersFilter filter) async {
    return await _repository.getCharacters(page, filter);
  }
}

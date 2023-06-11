import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

@injectable
class GetLocalCharacters {
  GetLocalCharacters(this._repository);

  final CharactersRepository _repository;

  Future<List<Character>> call() async {
    return await _repository.getLocalCharacters();
  }
}

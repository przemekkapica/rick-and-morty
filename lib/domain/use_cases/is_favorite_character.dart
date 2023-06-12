import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';

@injectable
class IsFavoriteCharacter {
  IsFavoriteCharacter(this._repository);

  final CharactersRepository _repository;

  Future<bool> call(int id) async {
    return await _repository.isFavoriteCharacter(id);
  }
}

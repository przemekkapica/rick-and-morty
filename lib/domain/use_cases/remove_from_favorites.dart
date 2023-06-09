import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';

@injectable
class RemoveFromFavorites {
  RemoveFromFavorites(this._repository);

  final FavoritesRepository _repository;

  Future<void> call(int id) async {
    return await _repository.removeFromFavorites(id);
  }
}

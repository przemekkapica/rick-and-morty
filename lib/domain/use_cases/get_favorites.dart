import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

@injectable
class GetFavorites {
  Future<List<Character>> call() async {
    return await Future.value([]);
  }
}

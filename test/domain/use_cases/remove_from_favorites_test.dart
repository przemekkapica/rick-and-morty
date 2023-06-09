import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  group('RemoveFromFavorites', () {
    late MockFavoritesRepository favoritesRepository;
    late RemoveFromFavorites removeFromFavorites;

    const id = 1;

    setUpAll(() {
      favoritesRepository = MockFavoritesRepository();

      removeFromFavorites = RemoveFromFavorites(favoritesRepository);
    });

    test('calls proper repo method', () async {
      when(() => favoritesRepository.removeFromFavorites(id))
          .thenAnswer((_) async => []);

      await removeFromFavorites(id);

      verify(() => favoritesRepository.removeFromFavorites(id)).called(1);
    });
  });
}

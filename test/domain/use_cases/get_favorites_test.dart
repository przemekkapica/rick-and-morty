import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  group('GetFavorites', () {
    late MockFavoritesRepository favoritesRepository;
    late GetFavorites getFavorites;

    setUpAll(() {
      favoritesRepository = MockFavoritesRepository();

      getFavorites = GetFavorites(favoritesRepository);
    });

    test('calls proper repo method', () async {
      when(favoritesRepository.getFavorites).thenAnswer((_) async => []);

      await getFavorites();

      verify(favoritesRepository.getFavorites).called(1);
    });
  });
}

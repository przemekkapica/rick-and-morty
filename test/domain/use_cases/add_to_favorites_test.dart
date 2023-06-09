import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockCharacter extends Mock implements Character {}

void main() {
  group('AddToFavorites', () {
    late MockFavoritesRepository favoritesRepository;
    late AddToFavorites addToFavorites;

    final character = MockCharacter();

    setUpAll(() {
      favoritesRepository = MockFavoritesRepository();

      addToFavorites = AddToFavorites(favoritesRepository);
    });

    test('calls proper repo method', () async {
      when(() => favoritesRepository.addToFavorites(character))
          .thenAnswer((_) async => []);

      await addToFavorites(character);

      verify(() => favoritesRepository.addToFavorites(character)).called(1);
    });
  });
}

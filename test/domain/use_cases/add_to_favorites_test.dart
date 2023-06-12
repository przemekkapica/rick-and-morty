import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  group('AddToFavorites', () {
    late MockFavoritesRepository favoritesRepository;
    late AddToFavorites addToFavorites;

    const character = Character(
      created: '',
      gender: Gender.female,
      id: 0,
      image: '',
      isFavorite: false,
      location: '',
      name: '',
      origin: '',
      species: '',
      status: Status.dead,
      type: '',
    );

    setUpAll(() {
      favoritesRepository = MockFavoritesRepository();

      addToFavorites = AddToFavorites(favoritesRepository);
    });

    test('calls proper repo method', () async {
      final favoriteCharacter = FavoriteCharacter.fromBaseCharacter(character);

      when(() => favoritesRepository.addToFavorites(favoriteCharacter))
          .thenAnswer((_) async {});

      await addToFavorites(character);

      verify(() => favoritesRepository.addToFavorites(favoriteCharacter))
          .called(1);
    });
  });
}

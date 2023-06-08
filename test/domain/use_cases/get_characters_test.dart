import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  group('GetCharacters test', () {
    late MockCharactersRepository charactersRepository;
    late GetCharacters getCharacters;

    setUpAll(() {
      charactersRepository = MockCharactersRepository();

      getCharacters = GetCharacters(charactersRepository);
    });

    test('Calls proper repo method', () async {
      when(charactersRepository.getCharacters).thenAnswer((_) async => []);

      await getCharacters();

      verify(charactersRepository.getCharacters).called(1);
    });
  });
}

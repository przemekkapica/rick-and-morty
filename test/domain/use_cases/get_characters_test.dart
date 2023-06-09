import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  group('GetCharacters test', () {
    late MockCharactersRepository charactersRepository;
    late GetCharacters getCharacters;

    const filter = CharactersFilter();

    final charactersPage = CharactersPage(
      characters: [],
      paginationInfo: PaginationInfo(
        currentPage: 1,
        totalPages: 1,
        hasNext: true,
        hasPrevious: false,
      ),
    );

    setUpAll(() {
      charactersRepository = MockCharactersRepository();

      getCharacters = GetCharacters(charactersRepository);
    });

    test('Calls proper repo method', () async {
      when(() => charactersRepository.getCharacters(1, filter))
          .thenAnswer((_) async => charactersPage);

      await getCharacters(1, filter);

      verify(() => charactersRepository.getCharacters(1, filter)).called(1);
    });
  });
}

import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';

@injectable
class GetCharacters {
  GetCharacters(this._repository);

  final CharactersRepository _repository;

  Future<CharactersPage> call(int? page, CharactersFilter? filter) async {
    return await _repository.getCharacters(
      page,
      filter.isFilterEnabled ? filter!.normalize : const CharactersFilter(),
    );
  }
}

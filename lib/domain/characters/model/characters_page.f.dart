import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';

part 'characters_page.f.freezed.dart';

@freezed
class CharactersPage with _$CharactersPage {
  factory CharactersPage({
    required List<Character> characters,
    required PaginationInfo paginationInfo,
  }) = _CharactersPage;
}

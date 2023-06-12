import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';

abstract class CharactersFilterBroadcaster {
  CharactersFilter get value;

  Stream<CharactersFilter> get stream;

  void add(CharactersFilter status);
}

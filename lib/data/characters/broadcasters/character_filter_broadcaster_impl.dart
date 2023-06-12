import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/broadcasters/characters_filter_broadcaster.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rxdart/subjects.dart';

@Singleton(as: CharactersFilterBroadcaster)
class CharactersFilterBroadcasterImpl implements CharactersFilterBroadcaster {
  final BehaviorSubject<CharactersFilter> _subject = BehaviorSubject();

  @override
  CharactersFilter get value => _subject.value;

  @override
  Stream<CharactersFilter> get stream => _subject.stream;

  @override
  void add(CharactersFilter status) => _subject.add(status);
}

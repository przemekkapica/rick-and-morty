import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/broadcasters/characters_filter_broadcaster.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';

@injectable
class GetLatestCharactersFilter {
  GetLatestCharactersFilter(this._broadcaster);

  final CharactersFilterBroadcaster _broadcaster;

  CharactersFilter call() {
    return _broadcaster.value;
  }
}

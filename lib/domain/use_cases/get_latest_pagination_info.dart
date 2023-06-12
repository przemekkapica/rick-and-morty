import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/broadcasters/pagination_info_broadcaster.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';

@injectable
class GetLatestPaginationInfo {
  GetLatestPaginationInfo(this._broadcaster);

  final PaginationInfoBroadcaster _broadcaster;

  PaginationInfo call() {
    return _broadcaster.value;
  }
}

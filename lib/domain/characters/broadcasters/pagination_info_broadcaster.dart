import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';

abstract class PaginationInfoBroadcaster {
  PaginationInfo get value;

  Stream<PaginationInfo> get stream;

  void add(PaginationInfo status);
}

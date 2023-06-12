import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/broadcasters/pagination_info_broadcaster.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';
import 'package:rxdart/subjects.dart';

@Singleton(as: PaginationInfoBroadcaster)
class PaginationInfoBroadcasterImpl implements PaginationInfoBroadcaster {
  final BehaviorSubject<PaginationInfo> _subject = BehaviorSubject();

  @override
  PaginationInfo get value => _subject.value;

  @override
  Stream<PaginationInfo> get stream => _subject.stream;

  @override
  void add(PaginationInfo status) => _subject.add(status);
}

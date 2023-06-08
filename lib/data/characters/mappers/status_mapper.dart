import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/domain/mappers/bidirectional_data_mapper.dart';

@injectable
class StatusMapper extends BidirectionalDataMapper<String, Status> {
  @override
  Status fromDTO(String dto) {
    if (dto == 'Alive') {
      return Status.alive;
    } else if (dto == 'Dead') {
      return Status.dead;
    } else {
      return Status.unknown;
    }
  }

  @override
  String toDTO(Status data) {
    switch (data) {
      case Status.alive:
        return 'alive';
      case Status.dead:
        return 'dead';
      case Status.unknown:
        return 'unknown';
    }
  }
}

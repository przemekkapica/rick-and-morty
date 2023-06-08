import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/domain/mappers/from_dto_mapper.dart';

@injectable
class StatusMapper extends DataMapper<String, Status> {
  @override
  Status call(String dto) {
    if (dto == 'Alive') {
      return Status.alive;
    } else if (dto == 'Dead') {
      return Status.dead;
    } else {
      return Status.unknown;
    }
  }
}

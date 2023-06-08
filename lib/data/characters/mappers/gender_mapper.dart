import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/mappers/from_dto_mapper.dart';

@injectable
class GenderMapper extends DataMapper<String, Gender> {
  @override
  Gender call(String dto) {
    if (dto == 'Female') {
      return Gender.female;
    } else if (dto == 'Male') {
      return Gender.male;
    } else if (dto == 'Genderless') {
      return Gender.genderless;
    } else {
      return Gender.unknown;
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/mappers/bidirectional_data_mapper.dart';

@injectable
class GenderMapper extends BidirectionalDataMapper<String, Gender> {
  @override
  Gender fromDTO(String dto) {
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

  @override
  String toDTO(Gender data) {
    switch (data) {
      case Gender.female:
        return 'female';
      case Gender.male:
        return 'male';
      case Gender.genderless:
        return 'genderless';
      case Gender.unknown:
        return 'unknown';
    }
  }
}

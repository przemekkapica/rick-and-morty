enum Gender {
  female,
  male,
  genderless,
  unknown,
}

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.female:
        return 'Female';
      case Gender.male:
        return 'Male';
      case Gender.genderless:
        return 'Genderless';
      default:
        return 'Unknown';
    }
  }
}

extension GenderStatus on String {
  Gender get toGender {
    return Gender.values.firstWhere(
      (e) => e.toString() == 'Gender.${toLowerCase()}',
      orElse: () => Gender.unknown,
    );
  }
}

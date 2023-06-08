// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:rick_and_morty/data/characters/data_sources/characters_data_source.dart'
    as _i9;
import 'package:rick_and_morty/data/characters/mappers/character_details_mapper.dart'
    as _i7;
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart'
    as _i8;
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart'
    as _i5;
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart'
    as _i6;
import 'package:rick_and_morty/data/networking/app_dio.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.Dio>(_i4.AppDio());
    gh.factory<_i5.GenderMapper>(() => _i5.GenderMapper());
    gh.factory<_i6.StatusMapper>(() => _i6.StatusMapper());
    gh.factory<_i7.CharacterDetailsMapper>(() => _i7.CharacterDetailsMapper(
          gh<_i6.StatusMapper>(),
          gh<_i5.GenderMapper>(),
        ));
    gh.factory<_i8.CharacterMapper>(
        () => _i8.CharacterMapper(gh<_i6.StatusMapper>()));
    gh.factory<_i9.CharactersDataSource>(
        () => _i9.CharactersDataSource(gh<_i3.Dio>()));
    return this;
  }
}

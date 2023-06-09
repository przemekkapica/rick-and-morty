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
import 'package:rick_and_morty/data/characters/characters_repository_impl.dart'
    as _i12;
import 'package:rick_and_morty/data/characters/data_sources/characters_data_source.dart'
    as _i10;
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart'
    as _i9;
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart'
    as _i6;
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart'
    as _i8;
import 'package:rick_and_morty/data/networking/app_dio.dart' as _i4;
import 'package:rick_and_morty/data/pagination/mappers/pagination_info_mapper.dart'
    as _i7;
import 'package:rick_and_morty/domain/characters/characters_repository.dart'
    as _i11;
import 'package:rick_and_morty/domain/use_cases/get_characters.dart' as _i13;
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart'
    as _i14;
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart'
    as _i5;

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
    gh.factory<_i5.FilterCharactersStore>(() => _i5.FilterCharactersStore());
    gh.factory<_i6.GenderMapper>(() => _i6.GenderMapper());
    gh.factory<_i7.PaginationInfoMapper>(() => _i7.PaginationInfoMapper());
    gh.factory<_i8.StatusMapper>(() => _i8.StatusMapper());
    gh.factory<_i9.CharacterMapper>(() => _i9.CharacterMapper(
          gh<_i8.StatusMapper>(),
          gh<_i6.GenderMapper>(),
        ));
    gh.factory<_i10.CharactersDataSource>(
        () => _i10.CharactersDataSource(gh<_i3.Dio>()));
    gh.lazySingleton<_i11.CharactersRepository>(
        () => _i12.CharactersRepositoryImpl(
              gh<_i10.CharactersDataSource>(),
              gh<_i9.CharacterMapper>(),
              gh<_i8.StatusMapper>(),
              gh<_i6.GenderMapper>(),
              gh<_i7.PaginationInfoMapper>(),
            ));
    gh.factory<_i13.GetCharacters>(
        () => _i13.GetCharacters(gh<_i11.CharactersRepository>()));
    gh.factory<_i14.CharactersListStore>(
        () => _i14.CharactersListStore(gh<_i13.GetCharacters>()));
    return this;
  }
}

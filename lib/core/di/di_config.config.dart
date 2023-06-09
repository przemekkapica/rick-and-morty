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
    as _i20;
import 'package:rick_and_morty/data/characters/data_sources/characters_data_source.dart'
    as _i18;
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart'
    as _i17;
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart'
    as _i10;
import 'package:rick_and_morty/data/characters/mappers/pagination_info_mapper.dart'
    as _i12;
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart'
    as _i14;
import 'package:rick_and_morty/data/favorites/data_sources/favorites_data_source.dart'
    as _i5;
import 'package:rick_and_morty/data/favorites/data_sources/local_favorites_data_source.dart'
    as _i6;
import 'package:rick_and_morty/data/favorites/favorites_repository_impl.dart'
    as _i8;
import 'package:rick_and_morty/data/networking/app_dio.dart' as _i4;
import 'package:rick_and_morty/domain/characters/characters_repository.dart'
    as _i19;
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart'
    as _i7;
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart' as _i15;
import 'package:rick_and_morty/domain/use_cases/get_characters.dart' as _i22;
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart' as _i11;
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart'
    as _i13;
import 'package:rick_and_morty/presentation/stores/character_details_store.dart'
    as _i16;
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart'
    as _i23;
import 'package:rick_and_morty/presentation/stores/favorites_store.dart'
    as _i21;
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart'
    as _i9;

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
    gh.lazySingleton<_i5.FavoritesDataSource>(
        () => _i6.LocalFavoritesDataSource());
    gh.lazySingleton<_i7.FavoritesRepository>(
        () => _i8.FavoritesRepositoryImpl(gh<_i5.FavoritesDataSource>()));
    gh.factory<_i9.FilterCharactersStore>(() => _i9.FilterCharactersStore());
    gh.factory<_i10.GenderMapper>(() => _i10.GenderMapper());
    gh.factory<_i11.GetFavorites>(
        () => _i11.GetFavorites(gh<_i7.FavoritesRepository>()));
    gh.factory<_i12.PaginationInfoMapper>(() => _i12.PaginationInfoMapper());
    gh.factory<_i13.RemoveFromFavorites>(
        () => _i13.RemoveFromFavorites(gh<_i7.FavoritesRepository>()));
    gh.factory<_i14.StatusMapper>(() => _i14.StatusMapper());
    gh.factory<_i15.AddToFavorites>(
        () => _i15.AddToFavorites(gh<_i7.FavoritesRepository>()));
    gh.factory<_i16.CharacterDetailsStore>(() => _i16.CharacterDetailsStore(
          gh<_i15.AddToFavorites>(),
          gh<_i13.RemoveFromFavorites>(),
        ));
    gh.factory<_i17.CharacterMapper>(() => _i17.CharacterMapper(
          gh<_i14.StatusMapper>(),
          gh<_i10.GenderMapper>(),
        ));
    gh.factory<_i18.CharactersDataSource>(
        () => _i18.CharactersDataSource(gh<_i3.Dio>()));
    gh.lazySingleton<_i19.CharactersRepository>(
        () => _i20.CharactersRepositoryImpl(
              gh<_i18.CharactersDataSource>(),
              gh<_i17.CharacterMapper>(),
              gh<_i14.StatusMapper>(),
              gh<_i10.GenderMapper>(),
              gh<_i12.PaginationInfoMapper>(),
            ));
    gh.factory<_i21.FavoritesStore>(() => _i21.FavoritesStore(
          gh<_i11.GetFavorites>(),
          gh<_i13.RemoveFromFavorites>(),
        ));
    gh.factory<_i22.GetCharacters>(
        () => _i22.GetCharacters(gh<_i19.CharactersRepository>()));
    gh.factory<_i23.CharactersListStore>(() => _i23.CharactersListStore(
          gh<_i22.GetCharacters>(),
          gh<_i15.AddToFavorites>(),
        ));
    return this;
  }
}

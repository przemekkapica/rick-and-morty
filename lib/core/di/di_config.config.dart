// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connecteo/connecteo.dart' as _i3;
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:rick_and_morty/core/di/modules/util_module.dart' as _i34;
import 'package:rick_and_morty/data/characters/characters_repository_impl.dart'
    as _i26;
import 'package:rick_and_morty/data/characters/data_sources/characters_data_source.dart'
    as _i24;
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart'
    as _i23;
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart'
    as _i13;
import 'package:rick_and_morty/data/characters/mappers/pagination_info_mapper.dart'
    as _i15;
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart'
    as _i18;
import 'package:rick_and_morty/data/favorites/data_sources/favorites_data_source.dart'
    as _i8;
import 'package:rick_and_morty/data/favorites/data_sources/local_favorites_data_source.dart'
    as _i9;
import 'package:rick_and_morty/data/favorites/favorites_repository_impl.dart'
    as _i11;
import 'package:rick_and_morty/data/networking/app_dio.dart' as _i7;
import 'package:rick_and_morty/data/networking/broadcasters/connection_broadcaster_impl.dart'
    as _i28;
import 'package:rick_and_morty/data/networking/connection_inspector_impl.dart'
    as _i5;
import 'package:rick_and_morty/domain/characters/characters_repository.dart'
    as _i25;
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart'
    as _i10;
import 'package:rick_and_morty/domain/networking/broadcasters/connection_broadcaster.dart'
    as _i27;
import 'package:rick_and_morty/domain/networking/connection_inspector.dart'
    as _i4;
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart' as _i20;
import 'package:rick_and_morty/domain/use_cases/get_characters.dart' as _i30;
import 'package:rick_and_morty/domain/use_cases/get_connection_status.dart'
    as _i31;
import 'package:rick_and_morty/domain/use_cases/get_connection_status_stream.dart'
    as _i32;
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart' as _i14;
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart'
    as _i16;
import 'package:rick_and_morty/domain/use_cases/start_checking_connection.dart'
    as _i17;
import 'package:rick_and_morty/domain/use_cases/stop_checking_connection.dart'
    as _i19;
import 'package:rick_and_morty/presentation/stores/app_store.dart' as _i21;
import 'package:rick_and_morty/presentation/stores/character_details_store.dart'
    as _i22;
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart'
    as _i33;
import 'package:rick_and_morty/presentation/stores/favorites_store.dart'
    as _i29;
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart'
    as _i12;

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
    final utilModule = _$UtilModule();
    gh.lazySingleton<_i3.ConnectionChecker>(() => utilModule.connectionChecker);
    gh.lazySingleton<_i4.ConnectionInspector>(
        () => _i5.ConnectionInspectorImpl(gh<_i3.ConnectionChecker>()));
    gh.singleton<_i6.Dio>(_i7.AppDio());
    gh.lazySingleton<_i8.FavoritesDataSource>(
        () => _i9.LocalFavoritesDataSource());
    gh.lazySingleton<_i10.FavoritesRepository>(
        () => _i11.FavoritesRepositoryImpl(gh<_i8.FavoritesDataSource>()));
    gh.factory<_i12.FilterCharactersStore>(() => _i12.FilterCharactersStore());
    gh.factory<_i13.GenderMapper>(() => _i13.GenderMapper());
    gh.factory<_i14.GetFavorites>(
        () => _i14.GetFavorites(gh<_i10.FavoritesRepository>()));
    gh.factory<_i15.PaginationInfoMapper>(() => _i15.PaginationInfoMapper());
    gh.factory<_i16.RemoveFromFavorites>(
        () => _i16.RemoveFromFavorites(gh<_i10.FavoritesRepository>()));
    gh.factory<_i17.StartCheckingConnection>(
        () => _i17.StartCheckingConnection(gh<_i4.ConnectionInspector>()));
    gh.factory<_i18.StatusMapper>(() => _i18.StatusMapper());
    gh.factory<_i19.StopCheckingConnection>(
        () => _i19.StopCheckingConnection(gh<_i4.ConnectionInspector>()));
    gh.factory<_i20.AddToFavorites>(
        () => _i20.AddToFavorites(gh<_i10.FavoritesRepository>()));
    gh.factory<_i21.AppStore>(() => _i21.AppStore(
          gh<_i17.StartCheckingConnection>(),
          gh<_i19.StopCheckingConnection>(),
        ));
    gh.factory<_i22.CharacterDetailsStore>(() => _i22.CharacterDetailsStore(
          gh<_i20.AddToFavorites>(),
          gh<_i16.RemoveFromFavorites>(),
        ));
    gh.factory<_i23.CharacterMapper>(() => _i23.CharacterMapper(
          gh<_i18.StatusMapper>(),
          gh<_i13.GenderMapper>(),
        ));
    gh.factory<_i24.CharactersDataSource>(
        () => _i24.CharactersDataSource(gh<_i6.Dio>()));
    gh.lazySingleton<_i25.CharactersRepository>(
        () => _i26.CharactersRepositoryImpl(
              gh<_i24.CharactersDataSource>(),
              gh<_i23.CharacterMapper>(),
              gh<_i18.StatusMapper>(),
              gh<_i13.GenderMapper>(),
              gh<_i15.PaginationInfoMapper>(),
            ));
    gh.lazySingleton<_i27.ConnectionBroadcaster>(
        () => _i28.ConnectionBroadcasterImpl(gh<_i4.ConnectionInspector>()));
    gh.factory<_i29.FavoritesStore>(() => _i29.FavoritesStore(
          gh<_i14.GetFavorites>(),
          gh<_i16.RemoveFromFavorites>(),
        ));
    gh.factory<_i30.GetCharacters>(
        () => _i30.GetCharacters(gh<_i25.CharactersRepository>()));
    gh.factory<_i31.GetConnectionStatus>(
        () => _i31.GetConnectionStatus(gh<_i27.ConnectionBroadcaster>()));
    gh.factory<_i32.GetConnectionStatusStream>(
        () => _i32.GetConnectionStatusStream(gh<_i27.ConnectionBroadcaster>()));
    gh.factory<_i33.CharactersListStore>(() => _i33.CharactersListStore(
          gh<_i30.GetCharacters>(),
          gh<_i20.AddToFavorites>(),
        ));
    return this;
  }
}

class _$UtilModule extends _i34.UtilModule {}

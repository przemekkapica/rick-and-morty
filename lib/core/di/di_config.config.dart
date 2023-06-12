// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connecteo/connecteo.dart' as _i5;
import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:rick_and_morty/core/di/modules/util_module.dart' as _i48;
import 'package:rick_and_morty/data/characters/broadcasters/character_filter_broadcaster_impl.dart'
    as _i4;
import 'package:rick_and_morty/data/characters/broadcasters/pagination_info_broadcaster_impl.dart'
    as _i21;
import 'package:rick_and_morty/data/characters/characters_repository_impl.dart'
    as _i34;
import 'package:rick_and_morty/data/characters/data_sources/local/local_characters_data_source.dart'
    as _i18;
import 'package:rick_and_morty/data/characters/data_sources/local/local_characters_data_source_impl.dart'
    as _i19;
import 'package:rick_and_morty/data/characters/data_sources/remote/remote_characters_data_source.dart'
    as _i23;
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart'
    as _i32;
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart'
    as _i15;
import 'package:rick_and_morty/data/characters/mappers/pagination_info_mapper.dart'
    as _i22;
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart'
    as _i26;
import 'package:rick_and_morty/data/favorites/data_sources/favorites_data_source.dart'
    as _i10;
import 'package:rick_and_morty/data/favorites/data_sources/local_favorites_data_source.dart'
    as _i11;
import 'package:rick_and_morty/data/favorites/favorites_repository_impl.dart'
    as _i13;
import 'package:rick_and_morty/data/networking/app_dio.dart' as _i9;
import 'package:rick_and_morty/data/networking/broadcasters/connection_broadcaster_impl.dart'
    as _i36;
import 'package:rick_and_morty/data/networking/connection_inspector_impl.dart'
    as _i7;
import 'package:rick_and_morty/domain/characters/broadcasters/characters_filter_broadcaster.dart'
    as _i3;
import 'package:rick_and_morty/domain/characters/broadcasters/pagination_info_broadcaster.dart'
    as _i20;
import 'package:rick_and_morty/domain/characters/characters_repository.dart'
    as _i33;
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart'
    as _i12;
import 'package:rick_and_morty/domain/networking/broadcasters/connection_broadcaster.dart'
    as _i35;
import 'package:rick_and_morty/domain/networking/connection_inspector.dart'
    as _i6;
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart' as _i30;
import 'package:rick_and_morty/domain/use_cases/get_characters.dart' as _i37;
import 'package:rick_and_morty/domain/use_cases/get_connection_status.dart'
    as _i38;
import 'package:rick_and_morty/domain/use_cases/get_connection_status_stream.dart'
    as _i39;
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart' as _i16;
import 'package:rick_and_morty/domain/use_cases/get_latest_characters_filter.dart'
    as _i17;
import 'package:rick_and_morty/domain/use_cases/get_latest_pagination_info.dart'
    as _i40;
import 'package:rick_and_morty/domain/use_cases/get_local_characters.dart'
    as _i41;
import 'package:rick_and_morty/domain/use_cases/is_favorite_character.dart'
    as _i42;
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart'
    as _i24;
import 'package:rick_and_morty/domain/use_cases/save_characters_to_database.dart'
    as _i43;
import 'package:rick_and_morty/domain/use_cases/start_checking_connection.dart'
    as _i25;
import 'package:rick_and_morty/domain/use_cases/stop_checking_connection.dart'
    as _i27;
import 'package:rick_and_morty/domain/use_cases/update_characters_filter.dart'
    as _i28;
import 'package:rick_and_morty/domain/use_cases/update_local_character.dart'
    as _i44;
import 'package:rick_and_morty/domain/use_cases/update_pagination_info.dart'
    as _i29;
import 'package:rick_and_morty/presentation/stores/app_store.dart' as _i31;
import 'package:rick_and_morty/presentation/stores/character_details_store.dart'
    as _i45;
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart'
    as _i46;
import 'package:rick_and_morty/presentation/stores/favorites_store.dart'
    as _i47;
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart'
    as _i14;

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
    gh.singleton<_i3.CharactersFilterBroadcaster>(
        _i4.CharactersFilterBroadcasterImpl());
    gh.lazySingleton<_i5.ConnectionChecker>(() => utilModule.connectionChecker);
    gh.lazySingleton<_i6.ConnectionInspector>(
        () => _i7.ConnectionInspectorImpl(gh<_i5.ConnectionChecker>()));
    gh.singleton<_i8.Dio>(_i9.AppDio());
    gh.lazySingleton<_i10.FavoritesDataSource>(
        () => _i11.LocalFavoritesDataSource());
    gh.lazySingleton<_i12.FavoritesRepository>(
        () => _i13.FavoritesRepositoryImpl(gh<_i10.FavoritesDataSource>()));
    gh.factory<_i14.FilterCharactersStore>(() => _i14.FilterCharactersStore());
    gh.factory<_i15.GenderMapper>(() => _i15.GenderMapper());
    gh.factory<_i16.GetFavorites>(
        () => _i16.GetFavorites(gh<_i12.FavoritesRepository>()));
    gh.factory<_i17.GetLatestCharactersFilter>(() =>
        _i17.GetLatestCharactersFilter(gh<_i3.CharactersFilterBroadcaster>()));
    gh.lazySingleton<_i18.LocalCharactersDataSource>(
        () => _i19.LocalCharactersDataSourceImpl());
    gh.singleton<_i20.PaginationInfoBroadcaster>(
        _i21.PaginationInfoBroadcasterImpl());
    gh.factory<_i22.PaginationInfoMapper>(() => _i22.PaginationInfoMapper());
    gh.factory<_i23.RemoteCharactersDataSource>(
        () => _i23.RemoteCharactersDataSource(gh<_i8.Dio>()));
    gh.factory<_i24.RemoveFromFavorites>(
        () => _i24.RemoveFromFavorites(gh<_i12.FavoritesRepository>()));
    gh.factory<_i25.StartCheckingConnection>(
        () => _i25.StartCheckingConnection(gh<_i6.ConnectionInspector>()));
    gh.factory<_i26.StatusMapper>(() => _i26.StatusMapper());
    gh.factory<_i27.StopCheckingConnection>(
        () => _i27.StopCheckingConnection(gh<_i6.ConnectionInspector>()));
    gh.factory<_i28.UpdateCharactersFilter>(() =>
        _i28.UpdateCharactersFilter(gh<_i3.CharactersFilterBroadcaster>()));
    gh.factory<_i29.UpdatePaginationInfo>(
        () => _i29.UpdatePaginationInfo(gh<_i20.PaginationInfoBroadcaster>()));
    gh.factory<_i30.AddToFavorites>(
        () => _i30.AddToFavorites(gh<_i12.FavoritesRepository>()));
    gh.factory<_i31.AppStore>(() => _i31.AppStore(
          gh<_i25.StartCheckingConnection>(),
          gh<_i27.StopCheckingConnection>(),
        ));
    gh.factory<_i32.CharacterMapper>(() => _i32.CharacterMapper(
          gh<_i26.StatusMapper>(),
          gh<_i15.GenderMapper>(),
        ));
    gh.lazySingleton<_i33.CharactersRepository>(
        () => _i34.CharactersRepositoryImpl(
              gh<_i23.RemoteCharactersDataSource>(),
              gh<_i18.LocalCharactersDataSource>(),
              gh<_i32.CharacterMapper>(),
              gh<_i26.StatusMapper>(),
              gh<_i15.GenderMapper>(),
              gh<_i22.PaginationInfoMapper>(),
            ));
    gh.lazySingleton<_i35.ConnectionBroadcaster>(
        () => _i36.ConnectionBroadcasterImpl(gh<_i6.ConnectionInspector>()));
    gh.factory<_i37.GetCharacters>(
        () => _i37.GetCharacters(gh<_i33.CharactersRepository>()));
    gh.factory<_i38.GetConnectionStatus>(
        () => _i38.GetConnectionStatus(gh<_i35.ConnectionBroadcaster>()));
    gh.factory<_i39.GetConnectionStatusStream>(
        () => _i39.GetConnectionStatusStream(gh<_i35.ConnectionBroadcaster>()));
    gh.factory<_i40.GetLatestPaginationInfo>(() =>
        _i40.GetLatestPaginationInfo(gh<_i20.PaginationInfoBroadcaster>()));
    gh.factory<_i41.GetLocalCharacters>(
        () => _i41.GetLocalCharacters(gh<_i33.CharactersRepository>()));
    gh.factory<_i42.IsFavoriteCharacter>(
        () => _i42.IsFavoriteCharacter(gh<_i33.CharactersRepository>()));
    gh.factory<_i43.SaveCharactersToDatabase>(
        () => _i43.SaveCharactersToDatabase(gh<_i33.CharactersRepository>()));
    gh.factory<_i44.UpdateLocalCharacter>(
        () => _i44.UpdateLocalCharacter(gh<_i33.CharactersRepository>()));
    gh.factory<_i45.CharacterDetailsStore>(() => _i45.CharacterDetailsStore(
          gh<_i30.AddToFavorites>(),
          gh<_i24.RemoveFromFavorites>(),
          gh<_i44.UpdateLocalCharacter>(),
          gh<_i42.IsFavoriteCharacter>(),
          gh<_i38.GetConnectionStatus>(),
          gh<_i37.GetCharacters>(),
          gh<_i41.GetLocalCharacters>(),
        ));
    gh.factory<_i46.CharactersListStore>(() => _i46.CharactersListStore(
          gh<_i37.GetCharacters>(),
          gh<_i30.AddToFavorites>(),
          gh<_i24.RemoveFromFavorites>(),
          gh<_i41.GetLocalCharacters>(),
          gh<_i43.SaveCharactersToDatabase>(),
          gh<_i42.IsFavoriteCharacter>(),
          gh<_i44.UpdateLocalCharacter>(),
          gh<_i29.UpdatePaginationInfo>(),
          gh<_i28.UpdateCharactersFilter>(),
          gh<_i17.GetLatestCharactersFilter>(),
          gh<_i40.GetLatestPaginationInfo>(),
          gh<_i38.GetConnectionStatus>(),
          gh<_i39.GetConnectionStatusStream>(),
        ));
    gh.factory<_i47.FavoritesStore>(() => _i47.FavoritesStore(
          gh<_i16.GetFavorites>(),
          gh<_i24.RemoveFromFavorites>(),
          gh<_i41.GetLocalCharacters>(),
          gh<_i37.GetCharacters>(),
          gh<_i38.GetConnectionStatus>(),
          gh<_i17.GetLatestCharactersFilter>(),
          gh<_i40.GetLatestPaginationInfo>(),
        ));
    return this;
  }
}

class _$UtilModule extends _i48.UtilModule {}

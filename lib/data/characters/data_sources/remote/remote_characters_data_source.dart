import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/data/characters/dtos/get_characters_dto.dart';

part 'remote_characters_data_source.g.dart';

@RestApi()
@injectable
abstract class RemoteCharactersDataSource {
  @factoryMethod
  factory RemoteCharactersDataSource(Dio dio) = _RemoteCharactersDataSource;

  @GET('/character')
  Future<GetCharactersDTO> getCharacters(
    @Query('page') int? page,
    @Query('name') String? name,
    @Query('status') String? status,
    @Query('species') String? species,
    @Query('gender') String? gender,
  );
}

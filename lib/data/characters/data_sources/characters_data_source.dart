import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/data/characters/dtos/get_characters_dto.dart';

part 'characters_data_source.g.dart';

@RestApi()
@injectable
abstract class CharactersDataSource {
  @factoryMethod
  factory CharactersDataSource(Dio dio) = _CharactersDataSource;

  @GET('/characters')
  Future<GetCharactersDTO> getCharacters();
}

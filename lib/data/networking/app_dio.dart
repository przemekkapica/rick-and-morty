import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/config/env_config.dart';

class BaseDio extends DioMixin {
  BaseDio() {
    _initialize();
  }

  void _initialize() {
    httpClientAdapter = HttpClientAdapter();
    options = BaseOptions(
      baseUrl: EnvConfig.apiBaseUrl,
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 20),
    );
  }
}

@Singleton(as: Dio)
class AppDio extends BaseDio implements Dio {}

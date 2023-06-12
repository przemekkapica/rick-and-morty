import 'package:connecteo/connecteo.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/config/env_config.dart';

@module
abstract class UtilModule {
  @lazySingleton
  ConnectionChecker get connectionChecker => ConnectionChecker(
        baseUrlLookupAddress: EnvConfig.apiBaseUrl,
      );
}

import 'package:connecteo/connecteo.dart';
import 'package:injectable/injectable.dart';

@module
abstract class UtilModule {
  @lazySingleton
  ConnectionChecker get connectionChecker => ConnectionChecker();
}

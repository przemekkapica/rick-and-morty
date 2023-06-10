import 'package:rick_and_morty/domain/networking/model/connection_state.dart';

abstract class ConnectionBroadcaster {
  Stream<ConnectionStatus> get stream;

  Future<ConnectionStatus> getCurrentValue();
}

import 'package:rick_and_morty/domain/networking/model/connection_state.dart';

abstract class ConnectionInspector {
  Stream<ConnectionStatus> get connectionStatusStream;

  Future<ConnectionStatus> getConnectionStatus();

  void startCheckingConnection();

  void stopCheckingConnection();
}

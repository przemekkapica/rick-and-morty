import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/networking/broadcasters/connection_broadcaster.dart';
import 'package:rick_and_morty/domain/networking/connection_inspector.dart';
import 'package:rick_and_morty/domain/networking/model/connection_state.dart';

@LazySingleton(as: ConnectionBroadcaster)
class ConnectionBroadcasterImpl implements ConnectionBroadcaster {
  ConnectionBroadcasterImpl(this._connectionInspector);

  final ConnectionInspector _connectionInspector;

  @override
  Future<ConnectionStatus> getCurrentValue() =>
      _connectionInspector.getConnectionStatus();

  @override
  Stream<ConnectionStatus> get stream =>
      _connectionInspector.connectionStatusStream.asBroadcastStream();
}

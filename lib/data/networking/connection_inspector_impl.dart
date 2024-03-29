import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/networking/connection_inspector.dart';
import 'package:connecteo/connecteo.dart';
import 'package:rick_and_morty/domain/networking/model/connection_state.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: ConnectionInspector)
class ConnectionInspectorImpl implements ConnectionInspector {
  ConnectionInspectorImpl(this._connectionChecker);

  final ConnectionChecker _connectionChecker;

  bool _checkingEnabled = true;

  @override
  late final Stream<ConnectionStatus> connectionStatusStream =
      _onConnectionStatusChanged.asBroadcastStream();

  Stream<ConnectionStatus> get _onConnectionStatusChanged {
    return _connectionChecker.connectionStream
        .flatMap<ConnectionStatus>((isConnected) async* {
          if (!isConnected) {
            yield ConnectionStatus.disconnected;
          } else {
            yield ConnectionStatus.connected;
          }
        })
        .distinct()
        .doOnData((state) {
          print('New connection state: $state');
        });
  }

  @override
  Future<ConnectionStatus> getConnectionStatus() async {
    return await _connectionChecker.isConnected
        ? ConnectionStatus.connected
        : ConnectionStatus.disconnected;
  }

  @override
  void startCheckingConnection() {
    _checkingEnabled = true;
  }

  @override
  void stopCheckingConnection() {
    _checkingEnabled = false;
  }
}

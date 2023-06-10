import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/networking/connection_inspector.dart';

@injectable
class StopCheckingConnection {
  StopCheckingConnection(this._connectionInspector);

  final ConnectionInspector _connectionInspector;

  void call() {
    _connectionInspector.stopCheckingConnection();
  }
}

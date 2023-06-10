import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/networking/broadcasters/connection_broadcaster.dart';
import 'package:rick_and_morty/domain/networking/model/connection_state.dart';

@injectable
class GetConnectionStatus {
  GetConnectionStatus(this._connectionBroadcaster);

  final ConnectionBroadcaster _connectionBroadcaster;

  Future<ConnectionStatus> call() async {
    return await _connectionBroadcaster.getCurrentValue();
  }
}

import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/networking/broadcasters/connection_broadcaster.dart';
import 'package:rick_and_morty/domain/networking/model/connection_state.dart';

@injectable
class GetConnectionStatusStream {
  GetConnectionStatusStream(this._connectionBroadcaster);

  final ConnectionBroadcaster _connectionBroadcaster;

  Stream<ConnectionStatus> call() => _connectionBroadcaster.stream;
}

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/use_cases/start_checking_connection.dart';
import 'package:rick_and_morty/domain/use_cases/stop_checking_connection.dart';

part 'app_store.g.dart';

@injectable
class AppStore extends _AppStore with _$AppStore {
  AppStore(
    super.startCheckingConnection,
    super.stopCheckingConnection,
  );
}

abstract class _AppStore with Store {
  _AppStore(
    this._startCheckingConnection,
    this._stopCheckingConnection,
  );

  final StartCheckingConnection _startCheckingConnection;
  final StopCheckingConnection _stopCheckingConnection;

  @action
  void startCheckingConnection() {
    _startCheckingConnection();
  }

  @action
  void stopCheckingConnection() {
    _stopCheckingConnection();
  }
}

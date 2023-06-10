enum ConnectionStatus { connected, disconnected }

extension ConnectionStatusExtension on ConnectionStatus {
  bool get isConnected => this == ConnectionStatus.connected;
}

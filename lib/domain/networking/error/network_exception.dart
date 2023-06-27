import 'package:dio/dio.dart';

class NetworkException extends DioException {
  NetworkException({required super.requestOptions});
}

class NotFoundException extends NetworkException {
  NotFoundException({required super.requestOptions});
}

class TimeoutException extends NetworkException {
  TimeoutException({required super.requestOptions});
}

class BadResponseException extends NetworkException {
  BadResponseException({required super.requestOptions});
}

class ConnectionException extends NetworkException {
  ConnectionException({required super.requestOptions});
}

class UnknownNetworkException extends NetworkException {
  UnknownNetworkException({required super.requestOptions});
}

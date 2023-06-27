import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/networking/error/network_exception.dart';

@injectable
class DioExceptionMapper {
  NetworkException call(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout =>
        TimeoutException(requestOptions: e.requestOptions),
      DioExceptionType.sendTimeout =>
        TimeoutException(requestOptions: e.requestOptions),
      DioExceptionType.receiveTimeout =>
        TimeoutException(requestOptions: e.requestOptions),
      DioExceptionType.badResponse => _badResponseMapper(e),
      DioExceptionType.connectionError =>
        ConnectionException(requestOptions: e.requestOptions),
      DioExceptionType.badCertificate =>
        UnknownNetworkException(requestOptions: e.requestOptions),
      DioExceptionType.cancel =>
        UnknownNetworkException(requestOptions: e.requestOptions),
      DioExceptionType.unknown =>
        UnknownNetworkException(requestOptions: e.requestOptions),
    };
  }

  NetworkException _badResponseMapper(DioException e) {
    if (e.response != null && e.response!.statusCode == 404) {
      return NotFoundException(requestOptions: e.requestOptions);
    } else {
      return UnknownNetworkException(requestOptions: e.requestOptions);
    }
  }
}

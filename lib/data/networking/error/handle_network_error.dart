import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/networking/error/dio_exception_mapper.dart';
import 'package:synchronized/synchronized.dart';

@injectable
class HandleNetworkError {
  HandleNetworkError(this._dioExceptionMapper);

  final DioExceptionMapper _dioExceptionMapper;
  final Lock _lock = Lock();

  Future<T> call<T>(Future<T> Function() fn) async {
    return _lock.synchronized(() async {
      try {
        return await fn();
      } on DioException catch (e) {
        throw _dioExceptionMapper(e);
      } catch (_) {
        rethrow;
      }
    });
  }
}

import 'package:dio/dio.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';
import 'package:restart_app/restart_app.dart';

String baseUrl = 'http://dash.wolt.uz';

var options = BaseOptions(
  baseUrl: '$baseUrl/api/v1',
  contentType: 'application/json',
  headers: {
    'Accept': 'application/json',
  },
);

Dio dio = Dio(options)
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.path = '${options.path}/ru';

        return handler.next(options);
      },
      onError: (DioError e, handler) async {
        int? code = e.response!.statusCode;

        if (code == 401) {
          await TokenRepository().removeToken();
          Restart.restartApp();
        } else if (code == 500) {
          e.error = '_500';
          return handler.next(e);
        }
        e.error = e.response?.data['message'];

        return handler.next(e);
      },
    ),
  );

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

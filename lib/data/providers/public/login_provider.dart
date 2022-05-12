import 'package:dio/dio.dart';
import 'package:moreinfo/bloc/login/types.dart';
import '../config.dart';

Future<Response<dynamic>> loginPV(LoginCredentials data) async {
  try {
    var response = await dio.post(
      '/auth/login',
      data: {
        'username': data.username,
        'password': data.password,
      },
    );

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

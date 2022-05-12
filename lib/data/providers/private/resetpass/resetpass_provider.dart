import 'dart:async';
import 'package:dio/dio.dart';
import 'package:moreinfo/bloc/reset_pass/types.dart';
import '../../config.dart';

Future<Response<dynamic>> resetPassPV(ResetPassModel data) async {
  try {
    var response = await dio.post(
      '/profile/change-password',
      data: {
        'old_passowrd': data.old_password,
        'new_passowrd': data.new_password,
      },
    );

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

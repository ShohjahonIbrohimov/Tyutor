import 'package:dio/dio.dart';
import 'package:moreinfo/bloc/login/types.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';

import '../../config.dart';

Future<Response<dynamic>> resetPasswordPV(
    ResetPasswordPrivateModel data) async {
  try {
    var response = await dio.post(
      '/api/v1/profile/change-password',
      data: {
        'new_passowrd': data.new_passowrd,
        'old_passowrd': data.old_passowrd,
      },
    );

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

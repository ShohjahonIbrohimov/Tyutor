import 'package:dio/dio.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';
import '../config.dart';

Future<Response<dynamic>> sendCodePV(ResetPassModel data) async {
  try {
    var response = await dio.post(
      '/auth/confirmation-code',
      data: {
        'phone': data.phone,
        'code': data.code,
      },
    );

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

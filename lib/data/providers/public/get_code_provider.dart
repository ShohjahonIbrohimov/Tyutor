import 'package:dio/dio.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';
import '../config.dart';

Future<Response<dynamic>> getCodePV(ResetPassModel data) async {
  try {
    var response = await dio.post(
      '/auth/get-code-change-password',
      data: {
        'phone': data.phone,
      },
    );

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

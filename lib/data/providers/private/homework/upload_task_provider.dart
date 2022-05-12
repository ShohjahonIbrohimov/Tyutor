import 'dart:async';
import 'package:dio/dio.dart';
import '../../config.dart';

Future<Response<dynamic>> uploadTaskPV(
    Map<String, dynamic> data, int taskId) async {
  var formData = FormData.fromMap(data);

  try {
    var response = await dio.post(
      '/tyutor/report/create/$taskId',
      data: formData,
    );

    return response;
  } on DioError catch (e) {
    var response = e.response?.data['message'];
    var message;
    if (response.runtimeType == String) {
      message = response;
    }

    throw Failure(message);
  }
}

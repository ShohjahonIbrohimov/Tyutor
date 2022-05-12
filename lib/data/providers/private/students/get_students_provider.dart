import 'dart:async';
import 'package:dio/dio.dart';
import '../../config.dart';

Future<Response<dynamic>> getStudentsPV(String groupId) async {
  try {
    var response = await dio.get('/student/list/$groupId');

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

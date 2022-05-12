import 'dart:async';
import 'package:dio/dio.dart';
import '../../config.dart';

Future<Response<dynamic>> getFacultiesPV() async {
  try {
    var response = await dio.get('/student/faculties');

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

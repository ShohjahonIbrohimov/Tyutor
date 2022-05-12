import 'dart:async';
import 'package:dio/dio.dart';
import '../../config.dart';

Future<Response<dynamic>> getGroupsPV() async {
  try {
    var response = await dio.get('/groups/list');

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:moreinfo/bloc/reset_pass/types.dart';
import '../../config.dart';

Future<Response<dynamic>> getReportPV(reportId) async {
  try {
    var response = await dio.get('/tyutor/report/view/$reportId');

    return response;
  } on DioError catch (e) {
    String message = e.response?.data['message'];
    throw Failure(message);
  }
}

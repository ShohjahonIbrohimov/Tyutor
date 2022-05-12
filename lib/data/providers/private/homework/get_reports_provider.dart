import 'dart:async';
import 'package:dio/dio.dart';
import 'package:moreinfo/bloc/reset_pass/types.dart';
import '../../config.dart';

Future<Response<dynamic>> getReportsPV() async {
  try {
    var response = await dio.get('/tyutor/report/list');

    print(response);

    return response;
  } on DioError catch (e) {
    throw Failure(e.response!.statusMessage.toString());
  }
}

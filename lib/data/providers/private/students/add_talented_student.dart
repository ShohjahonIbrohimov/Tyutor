import 'dart:async';
import 'package:dio/dio.dart';
import '../../config.dart';

Future<Response<dynamic>> addTalentedStudentPV(
    Map<String, dynamic> data) async {
  print(data);
  Map<String, dynamic> toFilter = {...data};
  toFilter.removeWhere((key, value) => value == null || value == '');
  var formData = FormData.fromMap(toFilter);
  try {
    var response = await dio.post(
      '/student/talented/create',
      data: formData,
    );

    return response;
  } on DioError catch (e) {
    var message = e.response?.data['message'];

    throw Failure(message);
  }
}

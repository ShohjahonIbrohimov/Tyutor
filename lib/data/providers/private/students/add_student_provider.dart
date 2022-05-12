import 'dart:async';
import 'package:dio/dio.dart';
import '../../config.dart';

Future<Response<dynamic>> addStudentPV(Map<String, dynamic> data) async {
  Map<String, dynamic> toFilter = {...data};
  toFilter.removeWhere((key, value) => value == null || value == '');
  Map<String, dynamic> axtraData = {
    "birthday": data['birthday'] != null
        ? data['birthday'].toString().split(" ")[0].toString()
        : null,
    "receive_date": data['receive_date'] != null
        ? int.parse(data['receive_date'].toString().substring(0, 4))
        : null,
    "phone": data["phone"].toString().split(" ").join(),
  };

  Map<String, dynamic> dataTobeSent = data['user_photo'] != null
      ? {
          ...data,
          'photo': await MultipartFile.fromFile(data['user_photo']),
          ...axtraData,
        }
      : {
          ...data,
          ...axtraData,
        };
  var formData = FormData.fromMap(dataTobeSent);

  try {
    var response = await dio.post(
      '/student/create',
      data: formData,
    );

    return response;
  } on DioError catch (e) {
    var response = e.response?.data['message'];
    String message = '';
    if (response.runtimeType == String) {
      message = response;
    } else {
      Map<String, dynamic> res = response;
      res.forEach((k, v) {
        message += '${v[0]} (${dataTobeSent[k]})';
      });
    }
    throw Failure(message);
  }
}

import 'package:moreinfo/data/providers/private/students/add_student_provider.dart';
import 'package:moreinfo/data/providers/private/students/get_faculties_provider.dart';
import 'package:moreinfo/data/providers/private/students/get_student_provider.dart';
import 'package:moreinfo/data/providers/private/students/update_student_provider.dart';

class AddStudentRepository {
  Future<List> getFacultiesRP() async {
    var response = await getFacultiesPV();
    List data = response.data['data'];

    return data;
  }

  Future<String> addStudentRP(Map<String, dynamic> data) async {
    var response = await addStudentPV(data);
    String message = response.data['data'];
    return message;
  }

  Future<String> updateStudentRP(Map<String, dynamic> data, int studentId) async {
    var response = await updateStudentPV(data, studentId);
      String message = response.data['data'];
    return message;
  }

  Future<Map<String, dynamic>> getStudentRP(int studentId) async {
    var response = await getStudentPV(studentId);
    Map<String, dynamic> data = response.data['data'];

    Map<String, dynamic> toFilter = {...data};
    toFilter.removeWhere((key, value) => value == null || value == '');

    return toFilter;
  }
}

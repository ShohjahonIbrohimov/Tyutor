import 'package:moreinfo/data/models/student/student_model.dart';
import 'package:moreinfo/data/providers/private/students/add_talented_student.dart';
import 'package:moreinfo/data/providers/private/students/get_students_provider.dart';
import 'package:moreinfo/data/providers/private/students/get_talent_list.dart';
import 'package:moreinfo/data/providers/private/students/get_talented_students_provider.dart';

class StudentsRepository {
  Future<List<StudentModel>> getStudentsRP(String groupId) async {
    var response = await getStudentsPV(groupId);
    List data = response.data['data'];
    List<StudentModel> groups = data
        .map((e) => StudentModel.fromJson({...e, 'status': e['living_state']}))
        .toList();

    return groups;
  }

  Future<List> geTalentedtStudentsRP() async {
    var response = await getTalentedStudentsPV();
    List data = response.data['data'];

    return data;
  }

  Future<List> getTalentListRP() async {
    var response = await getTalentListPV();
    List data = response.data['data'];

    return data;
  }

  Future<void> addTalentRP(Map<String, dynamic> data) async {
    await addTalentedStudentPV(data);
  }
}

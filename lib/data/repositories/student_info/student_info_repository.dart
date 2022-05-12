import 'package:moreinfo/data/providers/private/students/get_student_provider.dart';
import 'package:moreinfo/presentation/helpers/helper_functions.dart';

class StudentInfoRepository {
  Future<Map<String, dynamic>> getStudentRP(int studentId) async {
    var response = await getStudentPV(studentId);
    Map<String, dynamic> data = response.data['data'];
    List abilities = data['abilities'];

    Map<String, dynamic> toFilter = {
      ...data,
      'birthday': DateTime.parse(data['birthday']),
      'receive_date': DateTime.parse(data['receive_date']),
      'faculty_id': data['facultyId'].toString(),
      'course': data['course'].toString(),
      'speciality_id': data['specialityId'].toString(),
      'group_id': data['groupId'].toString(),
      'rating_status': data['rating_status'].toString(),
      'behavior': data['behavior'].toString(),
      'phone': formatIncomingPhone(data['phone']),
      'fam_mother_phone': formatIncomingPhone(data['fam_mother_phone']),
      'fam_father_phone': formatIncomingPhone(data['fam_father_phone']),
      'student_id': data['id'].toString()
    };

    dynamic f = {};

    for (var i = 0; i < abilities.length; i++) {
      toFilter['abilities_ids[${abilities[i]['ability_id']}]'] =
          abilities[i]['ability_id'].toString();
      toFilter['value[${abilities[i]['ability_id']}]'] =
          abilities[i]['value'].toString();
    }

    toFilter.removeWhere(
        (key, value) => value == null || value == '' || value == 'null');

    return toFilter;
  }
}

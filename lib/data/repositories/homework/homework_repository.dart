import 'package:moreinfo/data/models/homework/homework_model.dart';
import 'package:moreinfo/data/models/report_model/report_model.dart';
import 'package:moreinfo/data/models/task_detail/task_detail_model.dart';
import 'package:moreinfo/data/providers/private/homework/get_report_provider.dart';
import 'package:moreinfo/data/providers/private/homework/get_reports_provider.dart';
import 'package:moreinfo/data/providers/private/homework/get_spirtual_lessons_provider.dart';
import 'package:moreinfo/data/providers/private/homework/get_task.dart';
import 'package:moreinfo/data/providers/private/homework/get_tasks_provider.dart';
import 'package:moreinfo/data/providers/private/homework/upload_task_provider.dart';

class HomeworkRepository {
  Future<List<HomeworkModel>> getHomeworkRP() async {
    var response = await getHomeworkPV();
    List data = response.data['data'];
    List<HomeworkModel> groups =
        data.map((e) => HomeworkModel.fromJson(e)).toList();

    return groups;
    // return [
    //   HomeworkModel(
    //     id: 1,
    //     beginning_date: '05.05.2022',
    //     deadline: '05.09.2022',
    //     status: 2,
    //   )
    // ];
  }

  Future<TaskDetailModel> getTaskRP(int taskId) async {
    var response = await getTaskPV(taskId);
    TaskDetailModel data = TaskDetailModel.fromJson(response.data['data']);

    return data;
    // return TaskDetailModel(
    //   id: 1,
    //   beginning_date: '05.05.2022',
    //   deadline: '05.09.2022',
    //   status: 2,
    //   task_description: 'Good',
    //   prorektor_description:
    //       "As such, a file that wants to use Freezed will start with",
    //   // completed_state: '90',
    //   taskFiles:
    //       'https://www.gettyimages.dk/gi-resources/images/500px/983794168.jpg',
    // );
  }

  Future<void> uploadTaskRP(Map<String, dynamic> data, int taskId) async {
    await uploadTaskPV(data, taskId);
  }

  Future<List<HomeworkModel>> getSpirtualLessonsRP() async {
    var response = await getSpirtualLessonsPV();
    List data = response.data['data'];
    List<HomeworkModel> groups =
        data.map((e) => HomeworkModel.fromJson(e)).toList();

    return groups;
  }

  Future<List<ReportModel>> getReportsRP() async {
    var response = await getReportsPV();
    List data = response.data['data'];
    List<ReportModel> groups =
        data.map((e) => ReportModel.fromJson(e)).toList();

    return groups;
    // return [
    //   ReportModel(
    //     id: 1,
    //     beginning_date: '05.05.2022',
    //     deadline: '05.09.2022',
    //     status: 2,
    //     prorektor_description:
    //         "As such, a file that wants to use Freezed will start with",
    //     compleated_persent: 90,
    //     taskFiles:
    //         'https://www.gettyimages.dk/gi-resources/images/500px/983794168.jpg',
    //   )
    // ];
  }

  Future<ReportModel> getReportRP(int reportId) async {
    var response = await getReportPV(reportId);
    ReportModel data = ReportModel.fromJson(response.data['data']);

    return data;
    // return ReportModel(
    //   id: 1,
    //   beginning_date: '05.05.2022',
    //   deadline: '05.09.2022',
    //   status: 2,
    //   prorektor_description:
    //       "As such, a file that wants to use Freezed will start with",
    //   compleated_persent: 90,
    //   taskFiles:
    //       'https://www.gettyimages.dk/gi-resources/images/500px/983794168.jpg',
    // );
  }
}

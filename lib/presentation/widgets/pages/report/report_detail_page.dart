import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/homework/homework_bloc.dart';
import 'package:moreinfo/cubit/task/task_cubit.dart';
import 'package:moreinfo/cubit/user/user_cubit.dart';
import 'package:moreinfo/data/models/report_model/report_model.dart';
import 'package:moreinfo/data/models/user/user_model.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/download_button.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/molecules/status_icon.dart';
import 'package:provider/src/provider.dart';

const description =
    'page when looking atill be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less The point of using Lorem Ipsum is that it has a more-or-less';

class ReportDetailPage extends StatefulWidget {
  const ReportDetailPage({Key? key}) : super(key: key);

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  int? reportId;
  UserModel? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int? id = context.read<TaskCubit>().state.id;
    context.read<HomeworkBloc>().add(StartFetchReport(id!));
    reportId = id;
    user = context.read<UserCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalization.of(context)!.translate('reports')),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: BlocBuilder<HomeworkBloc, HomeworkState>(
                builder: (context, state) {
                  if (state is HomeworkSuccess) {
                    int status = state.reportData!.status;
                    return StatusIcon(status: status);
                  }
                  return const Icon(
                    Icons.circle,
                    color: Colors.white,
                  );
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: AppContainer(
            child: BlocBuilder<HomeworkBloc, HomeworkState>(
              builder: (context, state) {
                if (state is HomeworkLoading) {
                  return const Center(child: Loading());
                } else if (state is HomeworkSuccess) {
                  return ReportContent(
                    report: state.reportData!,
                    user: user,
                  );
                } else if (state is HomeworkError) {
                  return CustomError(text: state.message);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ReportContent extends StatelessWidget {
  ReportModel report;
  UserModel? user;

  ReportContent({
    Key? key,
    required this.report,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.school_outlined,
              color: primaryColor,
            ),
            const SizedBox(width: 10),
            Text(
              user?.fio ?? '',
              style: const TextStyle(
                fontSize: 20,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          report.description,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 35),
        SectionTitle(
            title: AppLocalization.of(context)!.translate('_deadline')),
        const SizedBox(height: 10),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(color: primaryColor),
            children: <TextSpan>[
              TextSpan(
                text: report.beginning_date,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: red,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: ' - ',
              ),
              TextSpan(
                text: report.deadline,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: green,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            SectionTitle(
                title: AppLocalization.of(context)!
                    .translate('prorektor_comment')),
            const SizedBox(height: 5),
            Text(
              report.prorektor_description,
              style: const TextStyle(
                color: primaryColor,
                height: 1.5,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            SectionTitle(
                title: AppLocalization.of(context)!.translate('tutor_comment')),
            const SizedBox(height: 5),
            Text(
              report.prorektor_description,
              style: const TextStyle(
                color: primaryColor,
                height: 1.5,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        DownloadButton(
          url: report.taskFiles,
          title: AppLocalization.of(context)!.translate('download_task'),
        ),
        const SizedBox(height: 15),
        DownloadButton(
          url: report.taskFiles,
          title: AppLocalization.of(context)!.translate('download_report'),
        ),
        const SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: AppLocalization.of(context)!.translate('_pic')),
            const SizedBox(height: 5),
            const Text(
              "",
              style: TextStyle(
                color: primaryColor,
                height: 1.5,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
                title: AppLocalization.of(context)!.translate('task_rating')),
            const SizedBox(height: 10),
            Text(
              "${report.compleated_persent}/100",
              style: const TextStyle(
                color: primaryColor,
                fontSize: 18,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 15),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  String title;
  SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.circle,
          color: primaryColorLight,
          size: 10,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

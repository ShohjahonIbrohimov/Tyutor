import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/core/auth_page.dart';
import 'package:moreinfo/presentation/core/app_layout.dart';
import 'package:moreinfo/presentation/screens/auth/index.dart';
import 'package:moreinfo/presentation/screens/auth/reset_password_screen.dart';
import 'package:moreinfo/presentation/screens/home/lang_screen.dart';
import 'package:moreinfo/presentation/screens/home/news_more_screen.dart';
import 'package:moreinfo/presentation/screens/home/settings_screen.dart';
import 'package:moreinfo/presentation/screens/homework/homework_detail_screen.dart';
import 'package:moreinfo/presentation/screens/report/report_detail_screen.dart';
import 'package:moreinfo/presentation/screens/students/add_student_screen.dart';
import 'package:moreinfo/presentation/screens/talented_students/add_talented_student_screen.dart';
import 'package:moreinfo/presentation/widgets/pages/intro/index.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/start_auth':
        return MaterialPageRoute(builder: (_) => const AuthorizationScreen());
      case '/intro':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/reset_password':
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case '/cabinet_home':
        return MaterialPageRoute(builder: (_) => const AppLayout());
      case '/news_more':
        return MaterialPageRoute(builder: (_) => const NewsMoreScreen());
      case '/add_student':
        return MaterialPageRoute(builder: (_) => const AddStudentScreen());
      case '/add_talented_student':
        return MaterialPageRoute(
            builder: (_) => const AddTalentedStudentScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/lang':
        return MaterialPageRoute(builder: (_) => const LangScreen());
      case '/report_detail':
        return MaterialPageRoute(builder: (_) => const ReportDetailScreen());
      case '/homework_detail':
        return MaterialPageRoute(builder: (_) => const HomeworkDetailScreen());
    }

    return MaterialPageRoute(builder: (_) => const AuthPage());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/cubit/app_menu/app_menu_cubit.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/config/size_config.dart';
import 'package:moreinfo/presentation/screens/home/groups_screen.dart';
import 'package:moreinfo/presentation/screens/home/index.dart';
import 'package:moreinfo/presentation/screens/home/spirituality_screen.dart';
import 'package:moreinfo/presentation/screens/homework/index.dart';
import 'package:moreinfo/presentation/screens/report/index.dart';
import 'package:moreinfo/presentation/screens/spirtualty_lessons/index.dart';
import 'package:moreinfo/presentation/screens/students/index.dart';
import 'package:moreinfo/presentation/screens/talented_students/index.dart';
import 'package:moreinfo/presentation/widgets/molecules/user_menu.dart';
import 'package:moreinfo/presentation/widgets/pages/home/groups_page.dart';
import 'package:provider/src/provider.dart';

final menuItems = <MenuItem>[
  MenuItem(
    title: 'home',
    route: 0,
    children: [],
    icon: const Icon(
      Icons.home_rounded,
      color: primaryColor,
    ),
  ),
  MenuItem(
    title: 'homework',
    route: 1,
    icon: const Icon(
      Icons.assignment_outlined,
      color: primaryColor,
    ),
    children: [
      MenuItem(
        title: 'homework',
        route: 1,
        icon: const Icon(
          Icons.circle,
          color: primaryColor,
          size: 10,
        ),
        children: [],
      ),
      MenuItem(
        title: 'spirtuality_lessons',
        route: 2,
        icon: const Icon(
          Icons.circle,
          size: 10,
          color: primaryColor,
        ),
        children: [],
      )
    ],
  ),
  MenuItem(
    title: 'groups',
    route: 3,
    children: [],
    icon: const Icon(
      Icons.list_alt_rounded,
      color: primaryColor,
    ),
  ),
  MenuItem(
    title: 'reports',
    route: 4,
    children: [],
    icon: const Icon(
      Icons.feed_outlined,
      color: primaryColor,
    ),
  ),
  MenuItem(
    title: 'students',
    route: 5,
    icon: const Icon(
      Icons.people_outline_rounded,
      color: primaryColor,
    ),
    children: [
      MenuItem(
        title: 'students',
        route: 5,
        icon: const Icon(
          Icons.circle,
          size: 10,
          color: primaryColor,
        ),
        children: [],
      ),
      MenuItem(
        title: 'talented_students',
        route: 6,
        icon: const Icon(
          Icons.circle,
          size: 10,
          color: primaryColor,
        ),
        children: [],
      ),
    ],
  ),
];

class MenuItem {
  final String title;
  final Widget icon;
  final int route;
  final List<MenuItem> children;

  MenuItem({
    required this.route,
    required this.title,
    required this.children,
    required this.icon,
  });
}

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: AppLayout());

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentTab = 0;
  String currentTitle = 'home';

  List<Widget> screens = const [
    NewsScreen(),
    HomeworkScreen(),
    SpirtualtyLessonsScreen(),
    GroupsScreen(),
    ReportScreen(),
    StudentsScreen(),
    TalentedStudentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AppMenuCubit, AppMenuCubitModel>(
            builder: (context, state) {
              return Text(AppLocalization.of(context)!.translate(state.title));
            },
          ),
          centerTitle: true,
          actions: [UserMenu()],
        ),
        body: BlocBuilder<AppMenuCubit, AppMenuCubitModel>(
          builder: (context, state) {
            return screens[state.route];
          },
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: const BoxDecoration(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // flex: 5,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/logo2.png',
                              width: 45,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Oliy va o'rta maxsus  \nta'lim vazirligi",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              ...menuItems.map<Widget>((item) {
                if (item.children.isNotEmpty) {
                  return ExpansionTile(
                    leading: item.icon,
                    title: Transform.translate(
                      offset: const Offset(-20, 0),
                      child: Text(
                        AppLocalization.of(context)!.translate(item.title),
                        style: const TextStyle(color: primaryColor),
                      ),
                    ),
                    children: item.children.map<Widget>((item) {
                      return Container(
                        // decoration: BoxDecoration(
                        //   color: primaryColor,
                        //   border: Border(
                        //     top: BorderSide(color: primaryColorLight),
                        //   ),
                        // ),
                        child: ListTile(
                          dense: true,
                          // minVerticalPadding: 0,
                          // visualDensity: VisualDensity.compact,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                          title: Transform.translate(
                            offset: const Offset(50, 0),
                            child: Text(
                              AppLocalization.of(context)!
                                  .translate(item.title),
                              style: const TextStyle(color: primaryColor),
                            ),
                          ),
                          onTap: () {
                            context.read<AppMenuCubit>().setCurrentTab(
                                  AppMenuCubitModel(
                                    title: item.title,
                                    route: item.route,
                                  ),
                                );

                            Navigator.pop(context);
                          },
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return ListTile(
                    leading: item.icon,
                    title: Transform.translate(
                      offset: Offset(-20, 0),
                      child: Text(
                        AppLocalization.of(context)!.translate(item.title),
                        style: const TextStyle(color: primaryColor),
                      ),
                    ),
                    onTap: () {
                      context
                          .read<AppMenuCubit>()
                          .setCurrentTab(AppMenuCubitModel(
                            title: item.title,
                            route: item.route,
                          ));
                      Navigator.pop(context);
                    },
                  );
                }
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

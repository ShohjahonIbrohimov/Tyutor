import 'package:flutter_bloc/flutter_bloc.dart';

class AppMenuCubitModel {
  String title;
  int route;

  AppMenuCubitModel({
    required this.title,
    required this.route,
  });
}

class AppMenuCubit extends Cubit<AppMenuCubitModel> {
  AppMenuCubit() : super(AppMenuCubitModel(route: 0, title: 'home'));

  void setCurrentTab(AppMenuCubitModel val) => emit(val);
}

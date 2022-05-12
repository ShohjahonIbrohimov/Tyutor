import 'package:flutter_bloc/flutter_bloc.dart';

class AddStudentCubitModel {
  int? id;
  bool isAdd;

  AddStudentCubitModel({this.id, required this.isAdd});
}

class AddStudentCubit extends Cubit<AddStudentCubitModel> {
  AddStudentCubit() : super(AddStudentCubitModel(isAdd: true));

  void setIsAdd(val) => emit(val);
}

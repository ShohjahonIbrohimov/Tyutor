import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassModel {
  String? phone;
  String? code;
  String? password;

  ResetPassModel({
    this.phone,
    this.code,
    this.password,
  });
}

class ResetPassCubit extends Cubit<ResetPassModel?> {
  ResetPassCubit() : super(null);

  void setPhone(ResetPassModel data) => emit(data);
}

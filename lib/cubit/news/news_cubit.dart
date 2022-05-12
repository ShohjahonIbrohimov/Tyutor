import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<Map<String, dynamic>> {
  NewsCubit() : super({});

  void setNews(Map<String, dynamic> val) => emit(val);
}

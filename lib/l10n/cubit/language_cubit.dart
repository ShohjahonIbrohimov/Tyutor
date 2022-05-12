import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super("ru");

  void changeLocale(locale) => emit(locale ?? 'ru');
}

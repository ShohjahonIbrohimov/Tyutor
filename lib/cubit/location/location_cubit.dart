import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class LocationCubit extends Cubit<Map<String, dynamic>?> {
  LocationCubit() : super(null);

  Future<void> setLocation(data) async {
    emit(data);
  }
}

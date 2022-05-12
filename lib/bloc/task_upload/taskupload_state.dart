part of 'taskupload_bloc.dart';

abstract class TaskUploadState extends Equatable {
  const TaskUploadState();

  @override
  List<Object?> get props => [];
}

class TaskUploadInitial extends TaskUploadState {}

class TaskUploadLoading extends TaskUploadState {}

class TaskUploadSuccess extends TaskUploadState {}

class TaskUploadError extends TaskUploadState {
  final String message;
  const TaskUploadError(this.message);
}

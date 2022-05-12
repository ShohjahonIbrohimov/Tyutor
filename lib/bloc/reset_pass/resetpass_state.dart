part of 'resetpass_bloc.dart';

abstract class ResetPassState extends Equatable {
  const ResetPassState();

  @override
  List<Object?> get props => [];
}

class ResetPassInitial extends ResetPassState {}

class ResetPassLoading extends ResetPassState {}

class ResetPassSuccess extends ResetPassState {}

class ResetPassError extends ResetPassState {
  final String message;
  const ResetPassError(this.message);
}

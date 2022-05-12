part of 'resetpass_bloc.dart';

abstract class ResetPassEvent extends Equatable {
  const ResetPassEvent();

  @override
  List<Object> get props => [];
}

class StartResetPass extends ResetPassEvent {
  ResetPassModel data;

  StartResetPass(this.data);
}

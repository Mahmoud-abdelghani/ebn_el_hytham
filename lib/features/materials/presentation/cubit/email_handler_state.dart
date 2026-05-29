part of 'email_handler_cubit.dart';

@immutable
sealed class EmailHandlerState {}

final class EmailHandlerInitial extends EmailHandlerState {}
final class EmailHandlerLoading extends EmailHandlerState {}
final class EmailHandlerSuccess extends EmailHandlerState {}
final class EmailHandlerError extends EmailHandlerState {
  final String message;
  EmailHandlerError(this.message);
}

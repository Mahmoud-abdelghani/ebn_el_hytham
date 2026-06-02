part of 'excel_handler_cubit.dart';

@immutable
sealed class ExcelHandlerState {}

final class ExcelHandlerInitial extends ExcelHandlerState {}
final class ExcelHandlerLoading extends ExcelHandlerState {}
final class ExcelHandlerSuccess extends ExcelHandlerState {}
final class ExcelHandlerFailure extends ExcelHandlerState {
  final String message;
  ExcelHandlerFailure(this.message);
}

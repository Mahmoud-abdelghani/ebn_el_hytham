part of 'pdf_helper_cubit.dart';

@immutable
sealed class PdfHelperState {}

final class PdfHelperInitial extends PdfHelperState {}
final class PdfHelperLoading extends PdfHelperState {}
final class PdfHelperSuccess extends PdfHelperState {}
final class PdfHelperFailure extends PdfHelperState {
  final String message;
  PdfHelperFailure(this.message);
}

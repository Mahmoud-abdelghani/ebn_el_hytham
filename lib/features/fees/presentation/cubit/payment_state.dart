part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}
final class PaymentLoading extends PaymentState {}
final class PaymentSuccess extends PaymentState {
  final String clientSecret;
  PaymentSuccess({required this.clientSecret});
}
final class PaymentError extends PaymentState {
  final String message;
  PaymentError({required this.message});
}

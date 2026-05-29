part of 'layha_cubit.dart';

@immutable
sealed class LayhaState {}

final class LayhaInitial extends LayhaState {}
final class LayhaLoading extends LayhaState {}
final class LayhaSuccess extends LayhaState {
  final FinalLayhaModel finalLayhaModel;
  LayhaSuccess(this.finalLayhaModel);
}
final class LayhaError extends LayhaState {
  final String message;
  LayhaError(this.message);
}

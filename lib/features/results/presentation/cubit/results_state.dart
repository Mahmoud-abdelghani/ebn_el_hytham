part of 'results_cubit.dart';

@immutable
sealed class ResultsState {}

final class ResultsInitial extends ResultsState {}
final class ResultsLoading extends ResultsState {}
final class ResultsSuccess extends ResultsState {
  final AcadymicModel model;

  ResultsSuccess({required this.model});
}
final class ResultsError extends ResultsState {
  final String message;

  ResultsError({required this.message});
}

part of 'instructor_profile_cubit.dart';

@immutable
sealed class InstructorProfileState {}

final class InstructorProfileInitial extends InstructorProfileState {}

final class InstructorProfileLoading extends InstructorProfileState {}

final class InstructorProfileSuccess extends InstructorProfileState {
  final InstructorModel profile;
  InstructorProfileSuccess({required this.profile});
}

final class InstructorProfileError extends InstructorProfileState {
  final String message;
  InstructorProfileError({required this.message});
}

part of 'instructor_timetable_cubit.dart';

@immutable
sealed class InstructorTimetableState {}

final class InstructorTimetableInitial extends InstructorTimetableState {}
final class InstructorTimetableLoading extends InstructorTimetableState {}
final class InstructorTimetableSuccess extends InstructorTimetableState {
  final List<InstructorMateriaTableModel> assignedCourses;
  InstructorTimetableSuccess(this.assignedCourses);
}
final class InstructorTimetableError extends InstructorTimetableState {
  final String message;
  InstructorTimetableError(this.message);
}

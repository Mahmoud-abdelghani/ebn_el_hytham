part of 'instructor_materials_cubit.dart';

@immutable
sealed class InstructorMaterialsState {}

final class InstructorMaterialsInitial extends InstructorMaterialsState {}

final class InstructorMaterialsUpdatreLoading extends InstructorMaterialsState {}
final class InstructorMaterialsUpdateSuccess extends InstructorMaterialsState {
  
}
final class InstructorMaterialsUpdateFailure extends InstructorMaterialsState {
  final String message;
  InstructorMaterialsUpdateFailure(this.message);
}

final class InstructorMaterialsLoading extends InstructorMaterialsState {}

final class InstructorMaterialsSuccess extends InstructorMaterialsState {
  final List<InstructorMaterialModel> materials;
  InstructorMaterialsSuccess(this.materials);
}

final class InstructorMaterialsFailure extends InstructorMaterialsState {
  final String message;
  InstructorMaterialsFailure(this.message);
}

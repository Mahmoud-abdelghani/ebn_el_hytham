part of 'assigned_materials_cubit.dart';

@immutable
sealed class AssignedMaterialsState {}

final class AssignedMaterialsInitial extends AssignedMaterialsState {}

class AssignedMaterialsLoading extends AssignedMaterialsState {}

class AssignedMaterialsSuccess extends AssignedMaterialsState {
  final List<AssignedMaterialModel> materials;
  AssignedMaterialsSuccess(this.materials);
}

class AssignedMaterialsFailure extends AssignedMaterialsState {
  final String message;
  AssignedMaterialsFailure(this.message);
}

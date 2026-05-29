import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/core/errors/server_exception.dart';
import 'package:ebn_el_hytham/features/materials/data/models/assigned_material_model.dart';
import 'package:meta/meta.dart';

part 'assigned_materials_state.dart';

class AssignedMaterialsCubit extends Cubit<AssignedMaterialsState> {
  AssignedMaterialsCubit(this.api) : super(AssignedMaterialsInitial());

  ApiConsumer api;

  Future<void> fetchAssignedMaterials({required String studentId}) async {
    emit(AssignedMaterialsLoading());
    try {
      final response = await api.get(
        '${EndPoints.fetchAssignedMaterials}$studentId',
      );
      final List coursesJson = response['courses'] as List;
      final List<AssignedMaterialModel> materials = coursesJson
          .map((e) => AssignedMaterialModel.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(AssignedMaterialsSuccess(materials));
    } on ServerException catch (e) {
      emit(AssignedMaterialsFailure(e.message));
    } on Exception catch (e) {
      emit(AssignedMaterialsFailure(e.toString()));
    }
  }
}

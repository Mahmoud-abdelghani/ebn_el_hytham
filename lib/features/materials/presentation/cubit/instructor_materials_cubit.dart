import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/core/errors/server_exception.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:meta/meta.dart';

part 'instructor_materials_state.dart';

class InstructorMaterialsCubit extends Cubit<InstructorMaterialsState> {
  InstructorMaterialsCubit(this.api) : super(InstructorMaterialsInitial());
  ApiConsumer api;

  List<InstructorMaterialModel> materialsGlobal = [];
  String instructorIdGlobal = '';

  Future<void> fetchInstructorMaterials({required String instructorId}) async {
    try {
      emit(InstructorMaterialsLoading());
      instructorIdGlobal = instructorId;
      final teacherRes = await api.get('${EndPoints.teacher}$instructorId');
      final dashboardRes = await api.get('${EndPoints.dashboard}$instructorId');

      final materials = InstructorMaterialModel.fromBothApis(
        teacherResponse: teacherRes,
        dashboardResponse: dashboardRes,
      );
      materialsGlobal = materials;

      emit(InstructorMaterialsSuccess(materials));
    } on ServerException catch (e) {
      emit(InstructorMaterialsFailure(e.message));
    } on Exception catch (e) {
      emit(InstructorMaterialsFailure(e.toString()));
    }
  }

  Future<void> updateDegrees({
    required int studentId,
    required String courseCode,
    required int yearWork,
    required int finalExam,
  }) async {
    try {
      emit(InstructorMaterialsUpdatreLoading());
      await api.post(
        '${EndPoints.updateGrades}$studentId/$courseCode',
        body: {"course_work": yearWork, "final_exam": finalExam},
      );

      emit(InstructorMaterialsUpdateSuccess());
      fetchInstructorMaterials(instructorId: instructorIdGlobal);
    } on ServerException catch (e) {
      emit(InstructorMaterialsUpdateFailure(e.message));
      fetchInstructorMaterials(instructorId: instructorIdGlobal);
    } on Exception catch (e) {
      emit(InstructorMaterialsUpdateFailure(e.toString()));
      fetchInstructorMaterials(instructorId: instructorIdGlobal);
    }
  }

  Future<void> addBonus({
    required int amount,
    required List<int> studentsIds,
    required String courseCode,
    required double maxMark,
  }) async {
    try {
      emit(InstructorMaterialsLoading());

      await api.post(
        '${EndPoints.addBonus}$courseCode/$maxMark',
        body: {"bonus_marks": amount, "student_ids": studentsIds},
      );
      emit(InstructorMaterialsAddBonusSuccess());
      fetchInstructorMaterials(instructorId: instructorIdGlobal);
    } on ServerException catch (e) {
      emit(InstructorMaterialsFailure(e.message));
    } on Exception catch (e) {
      emit(InstructorMaterialsFailure(e.toString()));
    }
  }
}

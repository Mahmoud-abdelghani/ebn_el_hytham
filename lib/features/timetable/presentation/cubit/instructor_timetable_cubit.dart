import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/core/errors/server_exception.dart';
import 'package:ebn_el_hytham/features/timetable/data/models/instructor_materia_table_model.dart';
import 'package:meta/meta.dart';

part 'instructor_timetable_state.dart';

class InstructorTimetableCubit extends Cubit<InstructorTimetableState> {
  InstructorTimetableCubit(this.api) : super(InstructorTimetableInitial());
  ApiConsumer api;

  Future<void> fetchTable({required String id}) async {
    try {
      emit(InstructorTimetableLoading());
  final response = await api.get('${EndPoints.teacher}$id');
     
    final List assignedCourses = response['assigned_courses'];
    List<InstructorMateriaTableModel> listOfInstructorMateriaTableModel = [];
  
    listOfInstructorMateriaTableModel = assignedCourses
        .map((course) => InstructorMateriaTableModel.fromJson(course))
        .toList();

    emit(InstructorTimetableSuccess(listOfInstructorMateriaTableModel));
} on ServerException catch (e) {
    emit(InstructorTimetableError(e.message));
} on Exception catch (e) {
    emit(InstructorTimetableError(e.toString()));
}
    

  }
}

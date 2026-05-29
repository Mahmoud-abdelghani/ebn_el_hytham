import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/core/errors/server_exception.dart';
import 'package:ebn_el_hytham/features/results/data/models/acadymic_model.dart';
import 'package:meta/meta.dart';

part 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(this.api) : super(ResultsInitial());
  ApiConsumer api;

  Future<void> fetchResultOfStudent({required String studentId}) async {
    try {
      emit(ResultsLoading());
      final response = await api.get('${EndPoints.fetchAcademic}$studentId');
      AcadymicModel model = AcadymicModel.fromJson(response);
      emit(ResultsSuccess(model: model));
    } on ServerException catch (e) {
      emit(ResultsError(message: e.message));
    } on Exception catch (e) {
      emit(ResultsError(message: e.toString()));
    }
  }
}

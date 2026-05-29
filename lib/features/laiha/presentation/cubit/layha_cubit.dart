import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/core/errors/server_exception.dart';
import 'package:ebn_el_hytham/features/laiha/data/models/final_layha_model.dart';
import 'package:meta/meta.dart';

part 'layha_state.dart';

class LayhaCubit extends Cubit<LayhaState> {
  LayhaCubit(this.api) : super(LayhaInitial());
  ApiConsumer api;

  Future<void> fetchLayha({
    required String department,
    required String id,
  }) async {
    try {
      emit(LayhaLoading());
      final response = await api.get(
        '${EndPoints.studentProgress}$id/$department',
      );
      FinalLayhaModel model = FinalLayhaModel.fromJson(response);
      emit(LayhaSuccess(model));
    } on ServerException catch (e) {
      emit(LayhaError(e.message));
    } on Exception catch (e) {
      emit(LayhaError(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/core/errors/server_exception.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.api) : super(AuthInitial());
  ApiConsumer api;

  Future<void> login({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      final response = await api.post(
        EndPoints.login,
        body: {'user_id': int.parse(email), 'password': int.parse(password)},
      );
      final token = response['Token'];

      emit(AuthSuccess(token: token));
    } on ServerException catch (e) {
      emit(AuthError(message: e.message));
    } on Exception catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}

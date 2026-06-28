import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  Future<void> fetchClientSecretFromBackend({required int amount}) async {
    try {
  emit(PaymentLoading());
  final response = await Supabase.instance.client.functions.invoke(
    'create-paymob-intention',
    body: {'amount': amount},
  );
  emit(PaymentSuccess(clientSecret: response.data['client_secret']));
} on Exception catch (e) {
  emit(PaymentError(message: e.toString()));
}
  }
}

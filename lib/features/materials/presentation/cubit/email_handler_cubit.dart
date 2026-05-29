import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

part 'email_handler_state.dart';

class EmailHandlerCubit extends Cubit<EmailHandlerState> {
  EmailHandlerCubit() : super(EmailHandlerInitial());
  Future<void> sendEmail(String email) async {
    try {
      emit(EmailHandlerLoading());

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          'subject': 'Student Affairs',
          'body': 'Hello Student',
        },
      );

      await launchUrl(emailUri);

      emit(EmailHandlerSuccess());
    } catch (e) {
      emit(EmailHandlerError(e.toString()));
    }
  }
}

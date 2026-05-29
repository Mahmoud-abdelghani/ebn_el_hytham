import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/services/voice_service.dart';
import 'package:meta/meta.dart';

part 'voice_helper_state.dart';

class VoiceHelperCubit extends Cubit<String> {
  final VoiceService voiceService;
  VoiceHelperCubit(this.voiceService) : super('Off');

  bool isOn = false;

  /// Voice assistant is only available in the student app flow (not instructor).
  bool isStudentSession = false;

  Future<void> setStudentSession(bool isStudent) async {
    isStudentSession = isStudent;
    if (!isStudentSession) {
      await stop();
    }
  }

  Future<void> start() async {
    if (!isStudentSession) return;

    isOn = true;

    await voiceService.init((status) {
      if (status == "done" && isOn) {
        start();
      }
    });

    await voiceService.startListening((text) {
      emit(text);
    });
  }

  Future<void> stop() async {
    isOn = false;

    await voiceService.stopListening();
  }
}

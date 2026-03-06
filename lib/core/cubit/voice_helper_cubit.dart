import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/services/voice_service.dart';
import 'package:meta/meta.dart';

part 'voice_helper_state.dart';

class VoiceHelperCubit extends Cubit<String> {
  final VoiceService voiceService;
  VoiceHelperCubit(this.voiceService) : super('');

  void start() async {
    await voiceService.init((status) {
      if (status == "done") {
        start();
      }
    });

    voiceService.startListening((text) {
      emit(text);
    });
  }
}

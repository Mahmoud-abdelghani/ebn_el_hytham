import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  final stt.SpeechToText speech = stt.SpeechToText();
 static FlutterTts flutterTts = FlutterTts();

  Future<bool> init(Function(String state) onState) async {
    return await speech.initialize(
      onStatus: (status) {
        onState(status);
      },
    );
  }

  void startListening(Function(String text) onResult) async {
    speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
        log(result.recognizedWords);
      },
    );
  }

  void stopListening() {
    speech.stop();
  }

  static Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }
}

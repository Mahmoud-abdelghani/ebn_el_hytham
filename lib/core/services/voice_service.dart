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

  Future<void> startListening(Function(String text) onResult) async {
    await speech.listen(
      onResult: (result) {
        if (!result.finalResult) return;
        final text = result.recognizedWords.trim();
        if (text.isEmpty) return;
        onResult(text);
        log(text);
      },
    );
  }

  Future<void> stopListening() async {
    log('off or ');
    await speech.cancel();
    await speech.stop();
    await flutterTts.stop();
  }

  static Future<void> speak(String text) async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }
}

import 'dart:async';

import 'package:translate_now/layers/domain/enum/speech_to_text.dart';

abstract class SpeechToTextService {
  bool get isAvailable;
  Stream<STTStatus> get status;

  FutureOr<bool> init();

  FutureOr<void> start();

  FutureOr<void> stop();

  FutureOr<void> cancel();

  FutureOr<void> dispose();

  Stream<String> get lastWords;
}

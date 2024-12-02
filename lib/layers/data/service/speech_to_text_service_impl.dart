import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:translate_now/layers/data/utils/logger.dart';
import 'package:translate_now/layers/domain/enum/speech_to_text.dart';
import 'package:translate_now/layers/domain/service/speech_to_text_service.dart';

class STTImpl extends SpeechToTextService {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  final StreamController<String> _speechStreamController =
      StreamController<String>.broadcast();
  final StreamController<STTStatus> _statusStreamController =
      StreamController<STTStatus>.broadcast();

  STTImpl() {
    init();
  }

  @override
  FutureOr<bool> init() async {
    _speechEnabled = await _speechToText.initialize();

    if (!_speechEnabled) {
      debugLog('Speech to text couldn\'t initialized');
    }

    _speechToText.statusListener = (status) {
      _statusStreamController.add(_getSTTFromRawStatus(status));
    };

    return _speechEnabled;
  }

  @override
  FutureOr<void> dispose() {
    _statusStreamController.close();
    _speechStreamController.close();
  }

  @override
  FutureOr<void> start() {
    return _speechToText.listen(onResult: (result) {
      _speechStreamController.add(result.recognizedWords);
    });
  }

  @override
  FutureOr<void> stop() {
    return _speechToText.stop();
  }

  @override
  bool get isAvailable => _speechToText.isAvailable;

  @override
  Stream<STTStatus> get status => _statusStreamController.stream;

  @override
  FutureOr<void> cancel() {
    return _speechToText.cancel();
  }

  @override
  Stream<String> get lastWords => _speechStreamController.stream;

  STTStatus _getSTTFromRawStatus(String value) {
    return STTStatus.values.firstWhere(
      (element) => element.name == value,
      orElse: () => STTStatus.unknown,
    );
  }
}

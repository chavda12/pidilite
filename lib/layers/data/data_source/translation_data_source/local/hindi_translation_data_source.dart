import 'dart:async';

import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import 'package:translate_now/layers/data/data_source/translation_data_source/base_translation_data_source.dart';
import 'package:translate_now/layers/data/utils/logger.dart';
import 'package:translate_now/layers/domain/enum/translation_language.dart';

class HindiTranslationDataSource extends BaseTranslationDataSource {
  final TranslateLanguage _sourceLanguage = TranslateLanguage.english;
  final TranslateLanguage _targetLanguage = TranslateLanguage.hindi;

  late final OnDeviceTranslator _translator;
  final _modelManager = OnDeviceTranslatorModelManager();

  final Completer<bool> _initCompleter = Completer<bool>();

  HindiTranslationDataSource() {
    init().then((value) {
      _initCompleter.complete(value);
    });
  }

  @override
  Future<String> translate(
    String text, [
    TranslationLanguage to = TranslationLanguage.hindi,
  ]) async {
    if (!_initCompleter.isCompleted) {
      await _initCompleter.future;
    }
    return _translator.translateText(text);
  }

  @override
  Future<bool> dispose() async {
    await _translator.close();
    return true;
  }

  @override
  Future<bool> init() async {
    final downloadedStatus = await Future.wait([
      _downloadModel(_sourceLanguage),
      _downloadModel(_targetLanguage),
    ]).catchError((e) {
      debugLog(e.toString());
      return <bool>[false, false];
    });

    final isReady = downloadedStatus.every((value) => value);

    if (!isReady) {
      debugLog(
        "Translation Data Source is not ready for"
        "Langauges ${_sourceLanguage.name} & ${_targetLanguage.name}",
      );
      return isReady;
    }

    _translator = OnDeviceTranslator(
      sourceLanguage: _sourceLanguage,
      targetLanguage: _targetLanguage,
    );

    debugLog("Translation Data Source is ready");
    return isReady;
  }

  Future<bool> _isModelDownloaded(TranslateLanguage lang) {
    return _modelManager.isModelDownloaded(
      lang.bcpCode,
    );
  }

  Future<bool> _downloadModel(TranslateLanguage lang) async {
    final isDownloaded = await _isModelDownloaded(lang);

    if (isDownloaded) return true;

    final didDownload = await _modelManager.downloadModel(lang.bcpCode);

    return didDownload;
  }
}

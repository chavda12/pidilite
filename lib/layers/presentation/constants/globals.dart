import 'package:flutter/widgets.dart';

BuildContext? _globalContext;

///
///
/// Call this only in main.dart
void setContext(BuildContext context) {
  _globalContext = context;
}


BuildContext get globalContext => _globalContext!;

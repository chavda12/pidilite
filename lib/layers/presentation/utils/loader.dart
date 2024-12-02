
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

BuildContext? _loaderContext;

void setLoadderContext(BuildContext context){
  _loaderContext = context;
}

void showLoader(){
  _loaderContext?.loaderOverlay.show();
}

void hideLoader(){
  _loaderContext?.loaderOverlay.hide();
}
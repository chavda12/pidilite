// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translate_now/layers/presentation/cubits/base_state.dart';
import 'package:translate_now/layers/presentation/utils/loader.dart';

extension CubitExt<T extends BaseState> on Cubit<T> {
  void startLoading() {
    emit(state.startLoading() as T);
    showLoader();
  }

  void stopLoading() {
    emit(state.stopLoading() as T);
    hideLoader();
  }
}

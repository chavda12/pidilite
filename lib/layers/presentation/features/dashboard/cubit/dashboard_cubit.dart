import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translate_now/layers/data/utils/logger.dart';
import 'package:translate_now/layers/di/setup_locators.dart';
import 'package:translate_now/layers/domain/entity/tnc_entity.dart';
import 'package:translate_now/layers/domain/entity/usecase_params/tnc_usecase_param.dart';
import 'package:translate_now/layers/domain/entity/usecase_params/translate_usecase_param.dart';
import 'package:translate_now/layers/domain/service/speech_to_text_service.dart';
import 'package:translate_now/layers/domain/usecase/tnc_usecase/tnc_usecase.dart';
import 'package:translate_now/layers/domain/usecase/translate_usecase/translate_usecase.dart';
import 'package:translate_now/layers/presentation/constants/globals.dart';
import 'package:translate_now/layers/presentation/extensions/cubit_extension.dart';
import 'package:translate_now/layers/presentation/features/dashboard/cubit/dashboard_state.dart';

DashboardCubit get dashboardCubit => globalContext.read<DashboardCubit>();
DashboardState get dashboardState => dashboardCubit.state;

class DashboardCubit extends Cubit<DashboardState> {
  TncUseCase get _tncUseCase => di<TncUseCase>();
  TranslateUsecase get _translateUsecase => di<TranslateUsecase>();
  SpeechToTextService get _speechToTextService => di<SpeechToTextService>();

  DashboardCubit() : super(DashboardState());

  final Map<int, String> _translations = {};

  Future<void> fetchAllData() async {
    try {
      startLoading();
      final data = await _tncUseCase.call(
        params: AllTncUsecaseParam(),
      );

      emit(state.copyWith(tncList: data));
    } catch (e, st) {
      debugLog(
        e.toString(),
        stackTrace: st,
      );
    } finally {
      stopLoading();
    }
  }

  Future<void> fetchTncPaginated() async {
    try {
      if (state.isLoading) return;

      final oldData = state.tncList;
      if (oldData.isAtLastPage) return;

      startLoading();

      final data = await _tncUseCase.call(
        params: PaginatedTncUsecaseParam(
          nextPage: oldData.nextPage,
          limit: oldData.limit,
        ),
      );

      final newData = oldData.addNewData(data);

      emit(state.copyWith(tncList: newData));
    } catch (e, st) {
      debugLog(
        e.toString(),
        stackTrace: st,
      );
    } finally {
      stopLoading();
    }
  }

  String getTranslation(TncEntity tnc) {
    return _translations[tnc.id] ?? "";
  }

  Future<String> transalteText(TncEntity tnc) async {
    try {
      startLoading();
      final data = await _translateUsecase.call(
        params: TranslateUsecaseParam.toHindi(tnc.value),
      );

      _translations[tnc.id] = data;
      return data;
    } catch (e, st) {
      debugLog(
        e.toString(),
        stackTrace: st,
      );
    } finally {
      stopLoading();
    }
    return "";
  }

  void addTnc(TncEntity tnc) {
    final oldData = state.tncList;
    final newData = oldData.copyWith(
      data: [...oldData, tnc],
    );

    emit(state.copyWith(tncList: newData));
  }

  void updateTnc(TncEntity tnc) {
    final index = state.tncList.indexWhere((element) => element.id == tnc.id);
    if (index == -1) return;
    final oldData = state.tncList;
    oldData[index] = tnc;

    emit(state.copyWith(tncList: oldData));
  }


  Future<String> getSpeechToText() async {
    try {
      startLoading();
      final data = await _speechToTextService.lastWords;
      // return data;
    } catch (e, st) {
      debugLog(
        e.toString(),
        stackTrace: st,
      );
    } finally {
      stopLoading();
    }
    return "";
  }

}

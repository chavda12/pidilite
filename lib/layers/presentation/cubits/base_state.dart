abstract class BaseState {
  final bool isLoading;

  BaseState({this.isLoading = false});

  BaseState startLoading();
  BaseState stopLoading();
}

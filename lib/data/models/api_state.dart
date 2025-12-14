class ApiState<T> {
  final T? data;
  final Exception? error;
  final bool loading;

  ApiState._({this.data, this.error, required this.loading});

  factory ApiState.loading() => ApiState._(loading: true);
  factory ApiState.success(T data) => ApiState._(data: data, loading: false);
  factory ApiState.error(Exception error) =>
      ApiState._(error: error, loading: false);
  factory ApiState.initial() => ApiState._(loading: false);
}

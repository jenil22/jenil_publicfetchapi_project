class AppResponse<T> {
  const AppResponse({required this.msg, this.hasError = false, this.response});

  final String msg;
  final bool hasError;
  final T? response;
}

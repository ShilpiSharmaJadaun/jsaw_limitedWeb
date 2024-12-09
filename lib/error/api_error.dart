class ApiError {
  final String message;
  const ApiError._(this.message);

  factory ApiError.internet() =>
      const ApiError._('Check your internet connection');
  factory ApiError.timeOut() =>
      const ApiError._('Timeout has been reached. Please try again later');
  factory ApiError.invalidDetails() =>
      const ApiError._('Login failed. Invalid Details');
  factory ApiError.fromResponse(String error) => ApiError._(error);
  factory ApiError.unKnown() => const ApiError._('An unknown error occurred');
}

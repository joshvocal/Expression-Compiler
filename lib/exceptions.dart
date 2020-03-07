class FormulaException implements Exception {
  final String message;

  FormulaException([this.message = '']);

  @override
  String toString() => 'FormulaException: $message';
}

class TokenException implements Exception {
  final String token;

  TokenException([this.token = '']);

  @override
  String toString() => 'Unsupported Token: $token';
}

class UnsupportedException implements Exception {
  final String message;

  UnsupportedException([this.message = '']);

  @override
  String toString() => 'Unsupported Operator: $message';
}

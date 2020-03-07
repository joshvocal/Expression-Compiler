import 'package:meta/meta.dart';

class Token {
  final TokenType type;
  final dynamic value;

  Token(this.type, this.value);

  @override
  String toString() => type.toString();
}

class IntegerToken implements Token {
  @override
  TokenType get type => TokenType.integer;

  @override
  var value;
}

enum TokenType {
  integer,
  add,
  subtract,
  multiply,
  divide,
  openBracket,
  closeBracket,
  eof,
}

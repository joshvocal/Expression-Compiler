
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
  double value;

  IntegerToken(this.value);
}

class AddToken implements Token {
  @override
  TokenType get type => TokenType.add;

  @override
  String get value => '+';

  AddToken();
}

class SubtractToken implements Token {
  @override
  TokenType get type => TokenType.subtract;

  @override
  String get value => '-';

  SubtractToken();
}

class MultiplyToken implements Token {
  @override
  TokenType get type => TokenType.multiply;

  @override
  String get value => '*';

  MultiplyToken();
}

class DivideToken implements Token {
  @override
  TokenType get type => TokenType.divide;

  @override
  String get value => '/';

  DivideToken();
}

class OpenBracketToken implements Token {
  @override
  TokenType get type => TokenType.openBracket;

  @override
  String get value => '(';

  OpenBracketToken();
}

class CloseBracketToken implements Token {
  @override
  TokenType get type => TokenType.closeBracket;

  @override
  String get value => ')';

  CloseBracketToken();
}

class EOFToken implements Token {
  @override
  TokenType get type => TokenType.eof;

  @override
  String get value => null;

  EOFToken();
}

/// The types of [Token] objects.
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

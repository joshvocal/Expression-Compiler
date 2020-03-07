import 'package:meta/meta.dart';

class Token {
  TokenType type;
  dynamic value;

  Token({@required TokenType type, @required dynamic value}) {
    this.type = type;
    this.value = value;
  }

  @override
  String toString() => type.toString();
}

enum TokenType {
  INTEGER,
  PLUS,
  MINUS,
  MULTIPLY,
  DIVIDE,
  OPEN_BRACKET,
  CLOSE_BRACKET,
  EOF,
}

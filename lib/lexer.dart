import 'package:ast/exceptions.dart';
import 'package:ast/token.dart';

class Lexer {
  String _text;
  int _position;
  String _currentChar;

  Lexer(String text) {
    _text = text;
    _position = 0;
    _currentChar = text[_position];
  }

  void advance() {
    _position += 1;

    if (_position > _text.length - 1) {
      _currentChar = null;
    } else {
      _currentChar = _text[_position];
    }
  }

  void skipWhitespace() {
    while (_currentChar != null && _currentChar == ' ') {
      advance();
    }
  }

  double integer() {
    var result = '';

    while (_currentChar != null && double.tryParse(_currentChar) != null) {
      result += _currentChar;
      advance();
    }

    if (double.tryParse(result) == null) {
      throw FormatException();
    }

    return double.parse(result);
  }

  Token getNextToken() {
    while (_currentChar != null) {
      if (_currentChar == ' ') {
        skipWhitespace();
        continue;
      }

      if (double.tryParse(_currentChar) != null) {
        return Token(type: TokenType.INTEGER, value: integer());
      }

      if (_currentChar == '+') {
        advance();
        return Token(type: TokenType.PLUS, value: '+');
      }

      if (_currentChar == '-') {
        advance();
        return Token(type: TokenType.MINUS, value: '-');
      }

      if (_currentChar == '*') {
        advance();
        return Token(type: TokenType.MULTIPLY, value: '*');
      }

      if (_currentChar == '/') {
        advance();
        return Token(type: TokenType.DIVIDE, value: '/');
      }

      if (_currentChar == '(') {
        advance();
        return Token(type: TokenType.OPEN_BRACKET, value: '(');
      }

      if (_currentChar == ')') {
        advance();
        return Token(type: TokenType.CLOSE_BRACKET, value: ')');
      }

      throw TokenException(_currentChar);
    }

    return Token(type: TokenType.EOF, value: null);
  }
}

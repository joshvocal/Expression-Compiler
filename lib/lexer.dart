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

  void _advance() {
    _position += 1;

    if (_position > _text.length - 1) {
      _currentChar = null;
    } else {
      _currentChar = _text[_position];
    }
  }

  void _skipWhitespace() {
    while (_currentChar != null && _currentChar == ' ') {
      _advance();
    }
  }

  double _parseNumber() {
    var result = '';

    while (_currentChar != null && double.tryParse(_currentChar) != null) {
      result += _currentChar;
      _advance();
    }

    if (double.tryParse(result) == null) {
      throw FormatException();
    }

    return double.parse(result);
  }

  Token getNextToken() {
    while (_currentChar != null) {
      if (_currentChar == ' ') {
        _skipWhitespace();
        continue;
      }

      if (double.tryParse(_currentChar) != null) {
        return IntegerToken(_parseNumber());
      }

      if (_currentChar == '+') {
        _advance();
        return AddToken();
      }

      if (_currentChar == '-') {
        _advance();
        return SubtractToken();
      }

      if (_currentChar == '*') {
        _advance();
        return MultiplyToken();
      }

      if (_currentChar == '/') {
        _advance();
        return DivideToken();
      }

      if (_currentChar == '(') {
        _advance();
        return OpenBracketToken();
      }

      if (_currentChar == ')') {
        _advance();
        return CloseBracketToken();
      }

      throw TokenException(_currentChar);
    }

    return EOFToken();
  }
}

import 'package:ast/ast_node.dart';
import 'package:ast/exceptions.dart';
import 'package:ast/lexer.dart';
import 'package:ast/token.dart';

class Parser {
  Lexer _lexer;
  Token _currentToken;

  Parser(Lexer lexer) {
    _lexer = lexer;
    _currentToken = lexer.getNextToken();
  }

  void eat(TokenType tokenType) {
    if (_currentToken.type == tokenType) {
      _currentToken = _lexer.getNextToken();
      return;
    }

    throw FormulaException('Error');
  }

  AstNode factor() {
    var token = _currentToken;
    print('Factor: ${_currentToken.type} ${_currentToken.value}');

    if (token.type == TokenType.INTEGER) {
      eat(TokenType.INTEGER);

      return Num(token);
    } else if (token.type == TokenType.OPEN_BRACKET) {
      eat(TokenType.OPEN_BRACKET);
      var node = expr();
      eat(TokenType.CLOSE_BRACKET);

      return node;
    }

    throw TokenException(token.value);
  }

  AstNode term() {
    var node = factor();
    print('Term: ${_currentToken.type} ${_currentToken.value}');

    while (
    [TokenType.MULTIPLY, TokenType.DIVIDE].contains(_currentToken.type)) {
      var token = _currentToken;

      if (token.type == TokenType.MULTIPLY) {
        eat(TokenType.MULTIPLY);
      } else if (token.type == TokenType.DIVIDE) {
        eat(TokenType.DIVIDE);
      }

      node = BinaryOp(left: node, op: token, right: factor());
    }

    return node;
  }

  AstNode expr() {
    var node = term();
    print('Expr: ${_currentToken.type} ${_currentToken.value}');

    while ([TokenType.PLUS, TokenType.MINUS].contains(_currentToken.type)) {
      var token = _currentToken;

      if (token.type == TokenType.PLUS) {
        eat(TokenType.PLUS);
      } else if (token.type == TokenType.MINUS) {
        eat(TokenType.MINUS);
      }

      node = BinaryOp(left: node, op: token, right: term());
    }

    return node;
  }

  AstNode parse() {
    return expr();
  }
}

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

  void consumeToken(TokenType tokenType) {
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
      consumeToken(TokenType.INTEGER);

      return NumberNode(token);
    } else if (token.type == TokenType.OPEN_BRACKET) {
      consumeToken(TokenType.OPEN_BRACKET);
      var node = expr();
      consumeToken(TokenType.CLOSE_BRACKET);

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
        consumeToken(TokenType.MULTIPLY);
      } else if (token.type == TokenType.DIVIDE) {
        consumeToken(TokenType.DIVIDE);
      }

      node = OperatorNode(left: node, op: token, right: factor());
    }

    return node;
  }

  AstNode expr() {
    var node = term();
    print('Expr: ${_currentToken.type} ${_currentToken.value}');

    while ([TokenType.PLUS, TokenType.MINUS].contains(_currentToken.type)) {
      var token = _currentToken;

      if (token.type == TokenType.PLUS) {
        consumeToken(TokenType.PLUS);
      } else if (token.type == TokenType.MINUS) {
        consumeToken(TokenType.MINUS);
      }

      node = OperatorNode(left: node, op: token, right: term());
    }

    return node;
  }

  AstNode parse() {
    return expr();
  }
}

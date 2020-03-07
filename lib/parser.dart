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

    if (token.type == TokenType.integer) {
      consumeToken(TokenType.integer);

      return NumberNode(token);
    } else if (token.type == TokenType.openBracket) {
      consumeToken(TokenType.openBracket);
      var node = expr();
      consumeToken(TokenType.closeBracket);

      return node;
    }

    throw TokenException(token.value);
  }

  AstNode term() {
    var node = factor();
    print('Term: ${_currentToken.type} ${_currentToken.value}');

    while (
        [TokenType.multiply, TokenType.divide].contains(_currentToken.type)) {
      var token = _currentToken;

      if (token.type == TokenType.multiply) {
        consumeToken(TokenType.multiply);
      } else if (token.type == TokenType.divide) {
        consumeToken(TokenType.divide);
      }

      node = OperatorNode(left: node, op: token, right: factor());
    }

    return node;
  }

  AstNode expr() {
    var node = term();
    print('Expr: ${_currentToken.type} ${_currentToken.value}');

    while ([TokenType.add, TokenType.subtract].contains(_currentToken.type)) {
      var token = _currentToken;

      if (token.type == TokenType.add) {
        consumeToken(TokenType.add);
      } else if (token.type == TokenType.subtract) {
        consumeToken(TokenType.subtract);
      }

      node = OperatorNode(left: node, op: token, right: term());
    }

    return node;
  }

  AstNode parse() {
    return expr();
  }
}

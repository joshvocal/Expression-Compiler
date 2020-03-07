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

  void _consumeToken(TokenType tokenType) {
    if (_currentToken.type == tokenType) {
      _currentToken = _lexer.getNextToken();
      return;
    }

    throw FormulaException('Token type does not match');
  }

  AstNode _factor() {
    var token = _currentToken;

    if (token.type == TokenType.integer) {
      _consumeToken(TokenType.integer);

      return NumberNode(token);
    } else if (token.type == TokenType.openBracket) {
      _consumeToken(TokenType.openBracket);
      var node = _expr();
      _consumeToken(TokenType.closeBracket);

      return node;
    }

    throw TokenException(token.value);
  }

  AstNode _term() {
    var node = _factor();

    while (
        [TokenType.multiply, TokenType.divide].contains(_currentToken.type)) {
      var token = _currentToken;

      if (token.type == TokenType.multiply) {
        _consumeToken(TokenType.multiply);
      } else if (token.type == TokenType.divide) {
        _consumeToken(TokenType.divide);
      }

      node = OperatorNode(left: node, op: token, right: _factor());
    }

    return node;
  }

  AstNode _expr() {
    var node = _term();

    while ([TokenType.add, TokenType.subtract].contains(_currentToken.type)) {
      var token = _currentToken;

      if (token.type == TokenType.add) {
        _consumeToken(TokenType.add);
      } else if (token.type == TokenType.subtract) {
        _consumeToken(TokenType.subtract);
      }

      node = OperatorNode(left: node, op: token, right: _term());
    }

    return node;
  }

  AstNode parse() {
    return _expr();
  }
}

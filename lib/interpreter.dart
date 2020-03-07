import 'dart:io';

import 'package:ast/ast_node.dart';
import 'package:ast/exceptions.dart';
import 'package:ast/parser.dart';
import 'package:ast/token.dart';
import 'package:meta/meta.dart';

class Interpreter {
  Parser _parser;

  Interpreter({@required Parser parser}) {
    _parser = parser;
  }

  dynamic visitNode(AstNode node) {
    if (node is OperatorNode) {
      return _visitOperatorNode(node);
    } else if (node is NumberNode) {
      return _visitNumberNode(node);
    }

    throw UnsupportedError(node.runtimeType.toString());
  }

  double _visitOperatorNode(OperatorNode node) {
    switch (node.op.type) {
      case TokenType.add:
        return visitNode(node.left) + visitNode(node.right);
        break;
      case TokenType.subtract:
        return visitNode(node.left) - visitNode(node.right);
        break;
      case TokenType.multiply:
        return visitNode(node.left) * visitNode(node.right);
        break;
      case TokenType.divide:
        return visitNode(node.left) / visitNode(node.right);
        break;
      case TokenType.openBracket:
      case TokenType.closeBracket:
      case TokenType.eof:
      case TokenType.integer:
        break;
    }

    throw TokenException(node.op.type.toString());
  }

  dynamic _visitNumberNode(NumberNode node) {
    return node.value;
  }

  dynamic interpret() {
    var tree = _parser.parse();
    return visitNode(tree);
  }
}

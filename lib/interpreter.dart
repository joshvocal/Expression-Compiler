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
    if (node is BinaryOp) {
      return visitBinaryOp(node);
    } else if (node is Num) {
      return visitNum(node);
    }

    throw UnsupportedError(node.runtimeType.toString());
  }

  double visitBinaryOp(BinaryOp node) {
    switch (node.op.type) {
      case TokenType.PLUS:
        return visitNode(node.left) + visitNode(node.right);
        break;
      case TokenType.MINUS:
        return visitNode(node.left) - visitNode(node.right);
        break;
      case TokenType.MULTIPLY:
        return visitNode(node.left) * visitNode(node.right);
        break;
      case TokenType.DIVIDE:
        return visitNode(node.left) / visitNode(node.right);
        break;
      case TokenType.OPEN_BRACKET:
      case TokenType.CLOSE_BRACKET:
      case TokenType.EOF:
      case TokenType.INTEGER:
        break;
    }

    throw TokenException(node.op.type.toString());
  }

  dynamic visitNum(Num node) {
    return node.value;
  }

  dynamic interpret() {
    var tree = _parser.parse();
    return visitNode(tree);
  }
}

import 'package:ast/token.dart';

abstract class AstNode {}

class OperatorNode extends AstNode {
  AstNode left;
  Token op;
  AstNode right;

  OperatorNode({AstNode left, Token op, AstNode right}) {
    this.left = left;
    this.op = op;
    this.right = right;
  }
}

class NumberNode extends AstNode {
  Token token;
  dynamic value;

  NumberNode(Token token) {
    this.token = token;
    value = token.value;
  }
}

import 'package:ast/token.dart';

abstract class AstNode {}

class BinaryOp extends AstNode {
  AstNode left;
  Token op;
  AstNode right;

  BinaryOp({AstNode left, Token op, AstNode right}) {
    this.left = left;
    this.op = op;
    this.right = right;
  }
}

class Num extends AstNode {
  Token token;
  dynamic value;

  Num(Token token) {
    this.token = token;
    value = token.value;
  }
}

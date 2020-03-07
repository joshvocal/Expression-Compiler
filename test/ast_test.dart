import 'package:ast/ast_node.dart';
import 'package:ast/exceptions.dart';
import 'package:ast/interpreter.dart';
import 'package:ast/token.dart';
import 'package:test/test.dart';

void main() {
  var interpreter = Interpreter(parser: null);

  test('should calculate 1 + 1 correctly', () {
    var plusToken = Token(type: TokenType.PLUS, value: '+');

    var addNode = OperatorNode(
      left: NumberNode(Token(type: TokenType.INTEGER, value: 1.0)),
      op: plusToken,
      right: NumberNode(Token(type: TokenType.INTEGER, value: 1.0)),
    );

    var actual = interpreter.visitNode(addNode);

    expect(2.0, actual);
  });

  test('should calculate 1 - 1 correctly', () {
    var minusToken = Token(type: TokenType.MINUS, value: '-');

    var minusNode = OperatorNode(
      left: NumberNode(Token(type: TokenType.INTEGER, value: 1.0)),
      op: minusToken,
      right: NumberNode(Token(type: TokenType.INTEGER, value: 1.0)),
    );

    var actual = interpreter.visitNode(minusNode);

    expect(0.0, actual);
  });

  test('should calculate 1 * 1 correctly', () {
    var multiplyToken = Token(type: TokenType.MULTIPLY, value: '*');

    var multiplyNode = OperatorNode(
      left: NumberNode(Token(type: TokenType.MULTIPLY, value: 1.0)),
      op: multiplyToken,
      right: NumberNode(Token(type: TokenType.MULTIPLY, value: 1.0)),
    );

    var actual = interpreter.visitNode(multiplyNode);

    expect(1.0, actual);
  });

  test('should calculate 1 / 1 correctly', () {
    var divideToken = Token(type: TokenType.DIVIDE, value: '/');

    var divideNode = OperatorNode(
      left: NumberNode(Token(type: TokenType.MULTIPLY, value: 1.0)),
      op: divideToken,
      right: NumberNode(Token(type: TokenType.MULTIPLY, value: 1.0)),
    );

    var actual = interpreter.visitNode(divideNode);

    expect(1.0, actual);
  });

  test('should throw UnsupportedException from operator', () {
    var divideToken = Token(type: TokenType.DIVIDE, value: 'a');

    try {
      var divideNode = OperatorNode(
        left: NumberNode(Token(type: TokenType.MULTIPLY, value: 1.0)),
        op: divideToken,
        right: NumberNode(Token(type: TokenType.MULTIPLY, value: 1.0)),
      );

      interpreter.visitNode(divideNode);
    } catch (e) {
      expect(e, UnsupportedException);
    }
  });
}

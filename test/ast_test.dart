import 'package:ast/exceptions.dart';
import 'package:ast/interpreter.dart';
import 'package:ast/lexer.dart';
import 'package:ast/parser.dart';
import 'package:test/test.dart';

void main() {
  test('should calculate 1 + 1 correctly', () {
    var lexer = Lexer(text: '1 + 1');
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var actualResult = interpreter.interpret();

    expect(actualResult, 2.0);
  });

  test('should calculate 1 - 1 correctly', () {
    var lexer = Lexer(text: '1 - 1');
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var actualResult = interpreter.interpret();

    expect(actualResult, 0.0);
  });

  test('should calculate 1 * 1 correctly', () {
    var lexer = Lexer(text: '1 * 1');
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var actualResult = interpreter.interpret();

    expect(actualResult, 1.0);
  });

  test('should calculate 1 / 1 correctly', () {
    var lexer = Lexer(text: '1 / 1');
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var actualResult = interpreter.interpret();

    expect(actualResult, 1.0);
  });

  test('should throw TokenException from operator', () {
    try {
      var lexer = Lexer(text: '1 a 1');
      var parser = Parser(lexer);
      var interpreter = Interpreter(parser: parser);
      interpreter.interpret();
    } catch (e) {
      expect(TokenException, e.runtimeType);
    }
  });

  test('should calculate brackets correctly', () {
    var lexer = Lexer(text: '4 * (1 + 1)');
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var actualResult = interpreter.interpret();

    expect(actualResult, 8.0);
  });

  test('should calculate a + b / (c - d) correctly', () {
    var lexer = Lexer(text: '4 + 3 / (2 - 1)');
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var actualResult = interpreter.interpret();

    expect(actualResult, 7.0);
  });

  test('should handle nested brackets correctly', () {
    var lexer = Lexer(text: '((5 + 1))');
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var actualResult = interpreter.interpret();

    expect(actualResult, 6.0);
  });
}

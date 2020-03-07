import 'dart:io';

import 'package:ast/interpreter.dart';
import 'package:ast/lexer.dart';
import 'package:ast/parser.dart';

void main() {
  while (true) {
    String text;

    try {
      text = stdin.readLineSync();
    } catch (e) {
      throw Exception('Input Error');
    }

    if (text == null) {
      continue;
    }

    var lexer = Lexer(text: text);
    var parser = Parser(lexer);
    var interpreter = Interpreter(parser: parser);
    var result = interpreter.interpret();

    print('Result: $result');
  }
}

import 'dart:math';

import 'package:calculator/gloabl.dart';
import 'package:math_expressions/math_expressions.dart';

String calculations(String input) {
  print(isDegree);

  input = input.replaceAll(
      RegExp(r'([a-zA-Z]|π)(\d)|(\))([a-zA-Z(])'), r'$1*$2$3*$4');
  print(input);

  input = input.replaceAll('×', '*');
  input = input.replaceAll('÷', '/');
  input = input.replaceAll('π', '3.14159265359');
  input = input.replaceAll('e', '2.718281828');
  input = input.replaceAll('√', 'sqrt');

  input = input.replaceAll('sin-¹', 'arcsin');
  input = input.replaceAll('cos-¹', 'arccos');
  input = input.replaceAll('tan-¹', 'arctan');

  bool isInfinit = false;
  BigInt bigInt;

  Parser p = Parser();

  if (input[0] == '+') {
    input = input.substring(1);
  }

  if (isDegree) {
    RegExp regExp =
        RegExp(r'(cos|sin|tan|arccos|arcsin|arctan)\((\d+(\.\d+)?)\)');
    input = input.replaceAllMapped(regExp, (match) {
      String function = match.group(1).toString();
      String argString = match.group(2).toString();
      calculations(argString);
      double argInRadians;
      try {
        double argInDegrees = double.parse(argString);
        argInRadians = argInDegrees * (pi / 180);
        print(argInRadians);
        // print('$function($argInDegrees) = $function($argInRadians)');
        if (function == 'tan' &&
            (argInDegrees == 90.0 || argInDegrees == 270.0)) {
          isInfinit = true;
        }
      } catch (e) {
        print('Error parsing argument: $argString');
        argInRadians = 0.0;
      }
      return '$function($argInRadians)';
    });
  }

  //to solve to log replacing log with ln/ln10
  // RegExp regExp1 = RegExp(r'log\(([\d.]+)\)');
  RegExp regExp1 = RegExp(r'log\(([\d.]+|sqrt\d+)\)');
  input = input.replaceAllMapped(regExp1, (match) {
    String argString = match.group(1).toString();
    Expression exp = p.parse(argString);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    double arg = double.parse(eval.toString());
    return 'ln($arg)/ln(10)';
  });

  print('res' + input);
  print(asin(0.5));

  try {
    Expression exp = p.parse(input);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    // String evalstr = eval.toString();
    // print(eval);
    // print(eval.toString().length);
    if (isInfinit == true || eval == "Infinity") {
      return ('∞');
    } else if (eval >= 10000000000000.0) {
      if (eval.toString().contains('e')) {
        List<String> parts = eval.toString().split('e+');
        BigInt significant = BigInt.parse(parts[0].replaceAll('.', ''));
        int exponent = int.parse(parts[1]);
        bigInt = significant * BigInt.from(10).pow(exponent);
        // print('answer' + bigInt.toString());
      } else {
        bigInt = BigInt.parse(
            eval.toString().substring(0, eval.toString().length - 2));
        // print('answer1' + bigInt.toString());
      }
      return bigInt.toString().substring(0, 4) +
          'e${eval.toString().length - 6}';
    } else if (eval % 1 == 0) {
      return eval.toInt().toString();
    } else {
      String tempans = eval.toStringAsPrecision(8);
      while (tempans.endsWith('0')) {
        tempans = tempans.substring(0, tempans.length - 1);
      }
      return tempans;
    }
  } catch (e) {
    print(e.toString());
    if (e.toString().length > 60) {
      return 'invalid input err';
    } else if (e.toString().endsWith('Infini')) {
      return 'very large number';
    } else {
      return e.toString().substring(16) + 'err';
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:kalkulator/widget/buttons.dart';

extension StringExtension on String {
  bool get isNumber => isNotEmpty && contains(RegExp(r'[0-9]'));
}

class Kalkulator extends StatelessWidget {
  final StreamController<String> inputDisplayController = StreamController();
  final StreamController<String> resultDisplayController = StreamController();

  final List<String> tempInputs = [];

  void clearAllInputs() {
    tempInputs.clear();
    inputDisplayController.sink.add('0');
    resultDisplayController.sink.add('');
  }

  num calculate(String oper, num number1, num number2) {
    switch (oper) {
      case '+':
        return number1 + number2;
      case '-':
        return number1 - number2;
      case '*':
        return number1 * number2;
      case '/':
        try {
          return number1 / number2;
        } catch (e) {
          return 0;
        }
      default:
        return 0;
    }
  }

  void calculateInputs() {
    if (tempInputs.isNotEmpty) {
      final previousInput = tempInputs.join();

      final tempNumbers = tempInputs.join().split(RegExp(r'[+-]|[/*]'));
      final tempOpers = tempInputs.join().split(RegExp(r'[0-9]'));
      tempOpers.removeWhere((e) => e.isEmpty);

      final mainNumbers = tempNumbers
          .map((e) => e.contains('.') ? double.parse(e) : int.parse(e))
          .toList();
      final mainOpers = List<String>.from(tempOpers);

      num result = 0;
      int countCalc = 0;

      if (mainOpers.isNotEmpty) {
        do {
          final oper = mainOpers.removeAt(0);

          if (countCalc == 0) {
            final number1 = mainNumbers.removeAt(0);
            final number2 = mainNumbers.removeAt(0);

            result = calculate(oper, number1, number2);
            countCalc++;
          } else {
            final number = mainNumbers.removeAt(0);
            result = calculate(oper, result, number);
            countCalc++;
          }
        } while (mainOpers.isNotEmpty);

        resultDisplayController.sink.add(previousInput);

        tempInputs.clear();
        tempInputs.add(result.toString());
        // inputDisplayController.sink.add(result.toString());
      }
    }
  }

  final List<List<String>> buttons = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', '*'],
    ['1', '2', '3', '-'],
    ['C', '0', '=', '+'],
  ];

  final Map<String, Color> buttonColors = {
    '=': Colors.orange,
    'C': Colors.red,
  };

  final Map<String, Color> buttonTextColors = {
    '/': Colors.purple,
    '*': Colors.purple,
    '-': Colors.purple,
    '+': Colors.purple,
    '=': Colors.white,
    'C': Colors.white,
  };

  Kalkulator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: StreamBuilder<String>(
                          stream: resultDisplayController.stream,
                          builder: (context, snapshot) {
                            final str = snapshot.data ?? '';
                            return Text(
                              str,
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w300,
                              ),
                            );
                          }),
                    ),
                    StreamBuilder<String>(
                        stream: inputDisplayController.stream,
                        builder: (context, snapshot) {
                          final str = snapshot.data ?? '0';
                          return Text(
                            str,
                            style: const TextStyle(
                              fontSize: 55.0,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 10.0,
                  right: 10.0,
                  bottom: 5.0,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 228, 228),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    for (final row in buttons)
                      Expanded(
                        child: Row(
                          children: [
                            for (final char in row)
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (char.isNumber) {
                                          tempInputs.add(char);
                                        } else if (['/', '*', '+', '-']
                                            .contains(char)) {
                                          if (tempInputs.isNotEmpty) {
                                            if (tempInputs.last.isNumber) {
                                              tempInputs.add(char);
                                            } else {
                                              tempInputs.removeLast();
                                              tempInputs.add(char);
                                            }
                                          }
                                          // jadi ga bisa => 20+-*/
                                        } else if (char == 'C') {
                                          clearAllInputs();
                                        } else if (char == '=') {
                                          calculateInputs();
                                        }

                                        inputDisplayController.sink
                                            .add(tempInputs.join());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  buttonColors.containsKey(char)
                                                      ? buttonColors[char]
                                                      : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10.0),
                                              )),
                                          child: Center(
                                            child: Text(
                                              char,
                                              style: TextStyle(
                                                fontSize: 23.0,
                                                fontWeight: FontWeight.bold,
                                                color: buttonTextColors
                                                        .containsKey(char)
                                                    ? buttonTextColors[char]
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

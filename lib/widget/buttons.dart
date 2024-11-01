import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
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
  };

  MyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: buttonColors.containsKey(char)
                                      ? buttonColors[char]
                                      : Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              child: Center(
                                child: Text(
                                  char,
                                  style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold,
                                    color: buttonTextColors.containsKey(char)
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
    );
  }
}

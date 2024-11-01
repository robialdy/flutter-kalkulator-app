import 'package:flutter/material.dart';
import 'package:kalkulator/widget/buttons.dart';

class Kalkulator extends StatelessWidget {
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
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        '123',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Text(
                      '123',
                      style: TextStyle(
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
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
                child: MyButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

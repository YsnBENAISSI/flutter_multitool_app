import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../main.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  double _result = 0;

  get num2 => null;

  void _calculate(String operator) {
    double? num1 = double.tryParse(_number1Controller.text);
    double? num2 = double.tryParse(_number2Controller.text);

    if (num1 == null || num2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
      return;
    }

    setState(() {
      switch (operator) {
        case '+':
          _result = num1 + num2;
          break;
        case '-':
          _result = num1 - num2;
          break;
        case '*':
          _result = num1 * num2;
          break;
        case '/':
          if (num2 == 0) {
            
            final snackBar = SnackBar(
              /// need to set following properties for best effect of awesome_snackbar_content
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Erreur',
                message:
                'Erreur de divisé sur Zero',

                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                contentType: ContentType.failure,
              ),
            );
            return;
          }
          _result = num1 / num2;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(
        title: const Text('Modern Calculator'),
      ),
      drawer: const CommonDrawer(currentPage: 'calculator'),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _number1Controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'First Number',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _number2Controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Second Number',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperatorButton('+'),
                _buildOperatorButton('-'),
                _buildOperatorButton('*'),
                _buildOperatorButton('/'),
              ],
            ),
            const SizedBox(height: 40),
            Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Result',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _result.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget _buildOperatorButton(String operator) {
    return ElevatedButton(
      onPressed: (){ 
        _calculate(operator);
        if (num2 == 0) {
          print("hola");
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Erreur',
              message:
              'Erreur de divisé sur Zero',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );
          return;
        }
        },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        operator,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _number1Controller.dispose();
    _number2Controller.dispose();
    super.dispose();
  }
}

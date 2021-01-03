import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String output = "0";
  String pre = "";

  Widget buildButton(String buttonText) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          setState(() {
            if (buttonText == "Clear") {
              equation = "0";
              output = "0";
              pre = "";
            } else if (buttonText == "Back") {
              if (pre != "=") {
                equation = equation.substring(0, equation.length - 1);
              } else {
                equation = output;
                output = "0";
              }
              if (equation == "") {
                equation = "0";
              }
            } else if (buttonText == "=") {
              try {
                Parser p = Parser();
                Expression exp = p.parse(equation);
                ContextModel cm = ContextModel();
                output = "${exp.evaluate(EvaluationType.REAL, cm)}";
              } catch (e) {
                output = "Error";
              }
            } else {
              if (pre == "=") {
                equation = output;
                output = "0";
              } else if (equation == "0") {
                equation = buttonText;
              } else {
                equation = equation + buttonText;
              }
            }
            pre = buttonText;
            output = double.parse(output).toStringAsFixed(2);
          });
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "$equation",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "$output",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 10.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("*"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("."),
                    buildButton("0"),
                    buildButton("="),
                    buildButton("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("Clear"),
                    buildButton("Back"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  SimpleCalculatorState createState() => SimpleCalculatorState();
}

class SimpleCalculatorState extends State<SimpleCalculator> {
  String result = "0";
  String equation = "0";
  String expression = "";
  buttonPresed(String btnText) {
    setState(() {
      if (btnText == "C") {
        result = "0";
        equation = "0";
      } else if (btnText == "Back") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == "=") {
        expression = equation;
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget buildButton(String btnText, double btnHeight, Color btnColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      color: btnColor,
      child: TextButton(
        onPressed: () => buttonPresed(btnText),
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 38.0),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("Back", 1, Colors.blue),
                      buildButton("+", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.blue),
                      buildButton("2", 1, Colors.blue),
                      buildButton("3", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.blue),
                      buildButton("5", 1, Colors.blue),
                      buildButton("6", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.blue),
                      buildButton("8", 1, Colors.blue),
                      buildButton("9", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.blue),
                      buildButton("0", 1, Colors.blue),
                      buildButton("00", 1, Colors.blue),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [buildButton("*", 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buildButton("/", 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buildButton("-", 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buildButton("=", 2, Colors.redAccent)],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

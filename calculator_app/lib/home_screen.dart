import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: resultWidget(),
            ),
            Expanded(
              flex: 2,
              child: buttonWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            alignment: Alignment.centerRight,
            child: Text(
              userInput,
              style: const TextStyle(
                fontSize: 32,
                color: Color.fromARGB(255, 225, 219, 219),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonHeight = constraints.maxHeight / 4;
        return Container(
          padding: const EdgeInsets.all(10),
          color: Colors.black,
          child: GridView.builder(
            itemCount: buttonList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 8,
              childAspectRatio:
                  constraints.maxWidth / (constraints.maxHeight / 1.25),
            ),
            itemBuilder: (context, index) {
              return SizedBox(
                height: buttonHeight,
                child: button(buttonList[index]),
              );
            },
          ),
        );
      },
    );
  }

  Color getColor(String text) {
    if (text == "AC" || text == "(" || text == ")") {
      return Colors.black;
    }
    return Colors.white;
  }

  Color getBgColor(String text) {
    if (text == "AC" || text == "(" || text == ")") {
      return const Color(0xFFD4D4D2);
    }
    if (text == "/" ||
        text == "x" ||
        text == "+" ||
        text == "-" ||
        text == "=") {
      return const Color(0xFFFF9500);
    }
    return const Color(0xFF505050);
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtonPress(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }

    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return;
      }
    }

    if (text == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }

    userInput = userInput + text;
  }

  calculate() {
    try {
      userInput = userInput.replaceAll('x', '*');
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}

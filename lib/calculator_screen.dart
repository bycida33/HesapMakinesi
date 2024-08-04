import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; // TODO: Birinci sayı değişkeni
  String operand = ""; // TODO: Operatör değişkeni (+, -, *, /)
  String number2 = ""; // TODO: İkinci sayı değişkeni

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // TODO: Çıktı bölgesi
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$number1$operand$number2".isEmpty
                        ? "0"
                        : "$number1$operand$number2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // TODO: Butonlar
            Wrap(
              children: Btn.buttonValues
                  .map((value) => SizedBox(
                width: value == Btn.n0
                    ? screenSize.width / 2
                    : (screenSize.width / 4),
                height: screenSize.width / 5,
                child: buildButton(value),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(100)),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              )),
        ),
      ),
    );
  }

  //#####

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete(); // TODO: Silme işlemi
      return;
    }

    if (value == Btn.clr) {
      clearAll(); // TODO: Tüm değerleri temizleme işlemi
      return;
    }
    if (value == Btn.per) {
      convertToPercentage(); // TODO: Yüzdeye çevirme işlemi
      return;
    }
    if (value == Btn.calculate) {
      calculate(); // TODO: Hesaplama işlemi
      return;
    }
    appendValue(value); // TODO: Değer ekleme işlemi
  }

  //#####

  void calculate() {
    // TODO: Hesaplama işlemi
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);
    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
    }
    setState(() {
      number1 = "$result";

      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }

  //#####

  void convertToPercentage() {
    // TODO: Yüzdeye çevirme işlemi
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // TODO: Eğer hesaplama işlemi varsa onu temizle
      return;
    }
    if (operand.isNotEmpty) {
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  //#####

  void clearAll() {
    // TODO: Tüm değerleri temizleme işlemi
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  //#####

  void delete() {
    // TODO: Tek karakter silme işlemi
    setState(() {
      if (number2.isNotEmpty) {
        number2 = number2.substring(0, number2.length - 1);
      } else if (operand.isNotEmpty) {
        operand = "";
      } else if (number1.isNotEmpty) {
        number1 = number1.substring(0, number1.length - 1);
      }
    });
  }

  //#####

  void appendValue(String value) {
    // TODO: Değer ekleme işlemi
    setState(() {
      if (value != Btn.dot && int.tryParse(value) == null) {
        // TODO: Eğer operatörse (.+-*/)
        if (operand.isNotEmpty && number2.isNotEmpty) {
          // TODO: Eğer operatör ve ikinci sayı doluysa hesapla
        }
        operand = value;
      } else if (operand.isEmpty) {
        // TODO: Birinci sayıya ekleme işlemi
        if (value == Btn.dot && number1.contains(Btn.dot)) return;
        if (value == Btn.dot && (number1.isEmpty || number1 == Btn.dot)) {
          number1 = "0.";
        } else {
          number1 += value;
        }
      } else {
        // TODO: İkinci sayıya ekleme işlemi
        if (value == Btn.dot && number2.contains(Btn.dot)) return;
        if (value == Btn.dot && (number2.isEmpty || number2 == Btn.dot)) {
          number2 = "0.";
        } else {
          number2 += value;
        }
      }
    });
  }

  //#####

  Color getBtnColor(value) {
    // TODO: Buton rengi belirleme işlemi
    if ([Btn.del, Btn.clr].contains(value)) {
      return Colors.blueGrey;
    } else if ([
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate,
    ].contains(value)) {
      return Colors.orange;
    } else {
      return Colors.black87;
    }
  }
}

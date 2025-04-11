import 'dart:math';

import 'package:ator_math_game/widgets/count_down_timer.dart';
import 'package:ator_math_game/widgets/false_animation.dart';
import 'package:ator_math_game/widgets/half_button.dart';
import 'package:ator_math_game/widgets/true_animation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int firstNumber = 0;
  int secondNumber = 0;
  int result = 0;
  int score = 0;
  int state = 0;
  final random = Random();

  List<int> sayilar = [5, 10, 15, 20];

  void generateRandomNumbers() {
    firstNumber = (1 + random.nextInt(10)).toInt();
    secondNumber = (1 + random.nextInt(10)).toInt();
    result = firstNumber + secondNumber;
    setState(() {});
    seperateList();
  }

  Future<void> checkAnswer(int answer) async {
    if (answer == result) {
      score++;
      showTruePopup(true);
    } else {
      //score--;
      showTruePopup(false);
    }
    state = 1;
    setState(() {});
    await Future.delayed(const Duration(seconds: 3));
    state = 0;
    generateRandomNumbers();

    setState(() {});
  }

  int randomNumber() {
    int yeniSayi = (1 + random.nextInt(20)).toInt();
    if (sayilar.contains(yeniSayi)) {
      return randomNumber();
    } else {
      return yeniSayi;
    }
  }

  void seperateList() {
    sayilar.first = result;
    for (int i = 1; i < sayilar.length; i++) {
      sayilar[i] = randomNumber();
    }
    setState(() {
      sayilar.shuffle();
    });
  }

  void showTruePopup(bool isTrue) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => isTrue ? TruePopupAnimation() : FalsePopupAnimation(),
    );
  }

  @override
  void initState() {
    super.initState();
    generateRandomNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 82,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.info_outline, size: 32),
                      ),
                    ),
                  ),
                  Text(
                    "$score",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  CountdownTimer(
                    seconds: 10,
                    state: state,
                    onFinished: () {
                      setState(() {
                        state = 2;
                        showTruePopup(false);
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              Text(
                "$firstNumber + $secondNumber = ?",
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    generateRandomNumbers();
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 80,
                    height: 50,
                    child: Icon(Icons.skip_next_rounded, size: 50),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HalfButton(
                        text: sayilar[0].toString(),
                        paddingWidth: 20,
                        state: state,
                        result: result,
                        onPressed: () {
                          checkAnswer(sayilar[0]);
                        },
                        height: 80,
                      ),
                      HalfButton(
                        text: sayilar[1].toString(),
                        paddingWidth: 20,
                        state: state,
                        result: result,

                        onPressed: () {
                          checkAnswer(sayilar[1]);
                        },
                        height: 80,
                      ),
                    ],
                  ),
                  SizedBox(height: 10, width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HalfButton(
                        text: sayilar[2].toString(),
                        paddingWidth: 20,
                        state: state,
                        result: result,

                        onPressed: () {
                          checkAnswer(sayilar[2]);
                        },
                        height: 80,
                      ),
                      HalfButton(
                        text: sayilar[3].toString(),
                        paddingWidth: 20,
                        state: state,
                        result: result,

                        onPressed: () {
                          checkAnswer(sayilar[3]);
                        },
                        height: 80,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

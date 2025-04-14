import 'dart:math';

import 'package:ator_math_game/enums/page_type.dart';
import 'package:ator_math_game/providers/game_settings_provider.dart';
import 'package:ator_math_game/utils/tools.dart';
import 'package:ator_math_game/widgets/count_down_timer.dart';
import 'package:ator_math_game/widgets/false_animation.dart';
import 'package:ator_math_game/widgets/global_appbar.dart';
import 'package:ator_math_game/widgets/half_button.dart';
import 'package:ator_math_game/widgets/true_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BaseGamePage extends StatefulWidget {
  const BaseGamePage({super.key, required this.title, required this.pageType});

  final String title;
  final PageType pageType;
  @override
  State<BaseGamePage> createState() => _BaseGamePageState();
}

class _BaseGamePageState extends State<BaseGamePage> {
  int firstNumber = 0;
  int secondNumber = 0;
  int result = 0;
  int score = 0;
  int minusScore = 0;
  int state = 0;
  final random = Random();
  Key countdownKey = UniqueKey();

  List<int> sayilar = [5, 10, 15, 20];

  void generateRandomNumbers() {
    firstNumber = (1 + random.nextInt(widget.pageType.firstNumber)).toInt();
    secondNumber = (1 + random.nextInt(widget.pageType.secondNumber)).toInt();
    result = widget.pageType.getResult(firstNumber, secondNumber);
    countdownKey = UniqueKey();

    setState(() {});
    seperateList();
  }

  Future<void> checkAnswer(int answer) async {
    if (answer == result) {
      score++;
      showTruePopup(true);
    } else {
      minusScore++;
      vibrate(duration: 500);
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
    int yeniSayi = (1 + random.nextInt(20)).toInt() * (result > 0 ? 1 : -1);
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
    final gameSettings = Provider.of<GameSettingsProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
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
                  ),
                  /* SizedBox(
                    width: 82,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          /*  showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Uyarı'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Bu bir popup mesajıdır.'),
                                    Text('Bu bir popup mesajıdır.'),
                                    Text('Bu bir popup mesajıdır.'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          ); */
                        },
                        icon: const Icon(Icons.info_outline, size: 32),
                      ),
                    ),
                  ), */
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.trophy,
                          size: 48,
                          color: Colors.amber,
                        ),
                        Text(
                          "   $score",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CountdownTimer(
                    key: countdownKey,
                    seconds: gameSettings.selectedGameType.time,
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
                "$firstNumber ${widget.pageType.symbol} $secondNumber = ?",
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    generateRandomNumbers();
                    state = 0;
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.skip_next_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
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

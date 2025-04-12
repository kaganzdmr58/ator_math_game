import 'package:ator_math_game/enums/page_type.dart';
import 'package:ator_math_game/pages/base_game_page.dart';
import 'package:ator_math_game/pages/settings_page.dart';
import 'package:ator_math_game/utils/tools.dart';
import 'package:ator_math_game/widgets/global_appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Ator Math Game',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                goto(
                    context,
                    BaseGamePage(
                      title: title,
                      pageType: PageType.plusTen,
                    ));
              },
              child: const Text('Start Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                goto(
                    context,
                    BaseGamePage(
                      title: title,
                      pageType: PageType.minusTen,
                    ));
              },
              child: const Text('Start Game Minus'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                goto(context, SettingsPage());
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

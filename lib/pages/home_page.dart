import 'package:ator_math_game/pages/plus_one_page.dart';
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
      appBar:CustomAppBar(),
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
                goto(context, PlusOnePage(title: title));
              },
              child: const Text('Start Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                goto(context, SettingsPage(title: title));
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ator_math_game/pages/settings_page.dart';
import 'package:ator_math_game/utils/tools.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title ?? 'Ator Math Game'),
      centerTitle: centerTitle,
      actions: actions ??
          [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  goto(context, SettingsPage(title: title ?? ''));
                },
                icon: Icon(Icons.settings),
              ),
            )
          ],
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

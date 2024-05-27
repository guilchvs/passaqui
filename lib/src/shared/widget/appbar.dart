import 'package:flutter/material.dart';

class PassaquiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PassaquiAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(r"Pa$$ aqui"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
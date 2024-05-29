import 'package:flutter/material.dart';

class PassaquiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PassaquiAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
    ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/images/passaqui_nav_logo.jpeg",
            height: 20,
          )
        ),
      ),
      title: const Text(r"Pa$$ aqui"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}


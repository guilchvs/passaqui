import 'package:flutter/material.dart';

class PassaquiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showLogo;

  const PassaquiAppBar({this.showBackButton = false, this.showLogo = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key, // Pass the key to the AppBar constructor
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : showLogo
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/passaqui_nav_logo.jpeg",
                      height: 20,
                    ),
                  ),
                )
              : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}


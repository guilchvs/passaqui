//import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//
//class PassaquiAppBar extends StatelessWidget implements PreferredSizeWidget {
//  final bool showBackButton;
//  final bool showLogo;
//
//  const PassaquiAppBar(
//      {this.showBackButton = false, this.showLogo = true, Key? key})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return AppBar(
//      key: key,
//      elevation: 0,
//      backgroundColor: Theme.of(context).primaryColor,
//      leading: showBackButton
//          ? IconButton(
//              icon: const Icon(Icons.arrow_back),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            )
//          : null,
//      title: showLogo
//          ? SvgPicture.asset(
//              "assets/images/logo_passaqui_hor_1.svg",
//              fit: BoxFit.contain,
//              height: 100,
//              width: 20,
//            )
//          : null,
//    );
//  }
//
//  @override
//  Size get preferredSize => const Size.fromHeight(56.0);
//}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PassaquiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showLogo;

  const PassaquiAppBar({
    this.showBackButton = false,
    this.showLogo = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: showBackButton,
      title: showLogo
          ? Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Image.asset(
                "assets/images/logo_passaqui_hor_1.png",
                fit: BoxFit.contain,
                height: 100,
                width: 90,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

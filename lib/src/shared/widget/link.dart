//import 'package:flutter/material.dart';
//
//class PassaquiLink extends StatelessWidget {
//  final String label;
//  final Function onTap;
//  final bool underline;
//
//  const PassaquiLink({
//    required this.label,
//    required this.onTap,
//    this.underline = false,
//
//    Key? key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        onTap.call();
//      },
//      child: Text(
//        label,
//        style: TextStyle(
//          color: Colors.white,
//          fontSize: 13,
//          decoration: underline ? TextDecoration.underline : TextDecoration.none,
//        ),
//      ),
//    );
//  }
//}
//

import 'package:flutter/material.dart';

class PassaquiLink extends StatelessWidget {
  final String label;
  final Function onTap;
  final bool underline;

  const PassaquiLink({
    required this.label,
    required this.onTap,
    this.underline = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Stack(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          if (underline)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

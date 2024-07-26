// import 'package:flutter/material.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
//
// enum PassaquiBottomSheetStyle {
//   primary,
//   secondary,
//   defaultLight,
//   defaultDark,
//   invertedPrimary
// }
//
// class CustomBottomSheet extends StatelessWidget {
//   final String title;
//   final dynamic content;
//   final String textOnTap;
//   final PassaquiButtonStyle buttonStyle;
//   final PassaquiBottomSheetStyle background;
//   final Function() onTap;
//
//   const CustomBottomSheet({
//     Key? key,
//     required this.title,
//     this.buttonStyle = PassaquiButtonStyle.defaultLight,
//     this.background = PassaquiBottomSheetStyle.primary,
//     required this.content,
//     required this.textOnTap,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Color backgroundColor = Colors.white;
//     Color titleColor = Colors.black;
//
//     switch (background) {
//       case PassaquiBottomSheetStyle.primary:
//         backgroundColor = const Color.fromRGBO(18, 96, 73, 1);
//         titleColor = Colors.white;
//         break;
//       default:
//         backgroundColor = Colors.white;
//         titleColor = Colors.black;
//     }
//
//     return ClipRRect(
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//       child: Container(
//         color: backgroundColor,
//         padding: const EdgeInsets.all(24.0),
//         height: 300,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: titleColor,
//               ),
//             ),
//             const SizedBox(height: 10),
//             content is Widget ? content : Text(content.toString()),
//             const SizedBox(height: 20),
//             PassaquiButton(
//               showArrow: true,
//               style: buttonStyle,
//               onTap: onTap,
//               label: textOnTap,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/button.dart';

enum PassaquiBottomSheetStyle {
  primary,
  secondary,
  defaultLight,
  defaultDark,
  invertedPrimary
}

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final dynamic content;
  final String textOnTap;
  final PassaquiButtonStyle buttonStyle;
  final PassaquiBottomSheetStyle background;
  final Function() onTap;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    this.buttonStyle = PassaquiButtonStyle.defaultLight,
    this.background = PassaquiBottomSheetStyle.primary,
    required this.content,
    required this.textOnTap,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color titleColor = Colors.black;

    switch (background) {
      case PassaquiBottomSheetStyle.primary:
        backgroundColor = const Color.fromRGBO(18, 96, 73, 1);
        titleColor = Colors.white;
        break;
      default:
        backgroundColor = Colors.white;
        titleColor = Colors.black;
    }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: content is Widget ? content : Text(content.toString()),
              ),
            ),
            const SizedBox(height: 20),
            PassaquiButton(
              showArrow: true,
              style: buttonStyle,
              onTap: onTap,
              label: textOnTap,
            ),
          ],
        ),
      ),
    );
  }
}

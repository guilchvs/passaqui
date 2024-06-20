// import 'package:flutter/material.dart';
//
// class PassaquiTextButton extends StatelessWidget {
//   final String label;
//   final Function()? onTap;
//   final bool isLeading;
//   final Color textColor;
//   final String fontFamily;
//   final double fontSize;
//   final FontWeight fontWeight;
//
//   const PassaquiTextButton({
//     Key? key,
//     required this.label,
//     this.onTap,
//     this.isLeading = false,
//     this.textColor = const Color(0xFF5D5D5DB2),
//     this.fontFamily = 'Raleway',
//     this.fontSize = 16,
//     this.fontWeight = FontWeight.w600,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Row(
//         children: [
//           isLeading
//               ? Icon(
//             Icons.arrow_back_ios,
//             color: Color(0xFFA8CA4B),
//             size: 18,
//           )
//               : const SizedBox(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontFamily: fontFamily,
//                 fontSize: fontSize,
//                 fontWeight: fontWeight,
//                 color: textColor,
//               ),
//             ),
//           ),
//           isLeading
//               ? const SizedBox()
//               : Icon(
//             Icons.arrow_forward_ios,
//             color: Color(0xFFA8CA4B),
//             size: 18,
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class PassaquiTextButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final bool isLeading;
  final Color textColor;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color arrowColor;

  const PassaquiTextButton({
    Key? key,
    required this.label,
    this.onTap,
    this.isLeading = false,
    this.textColor = const Color(0xFF5D5D5DB2),
    this.fontFamily = 'Raleway',
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.arrowColor = const Color(0xFFA8CA4B),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          isLeading
              ? Icon(
            Icons.arrow_back_ios,
            color: arrowColor,
            size: 18,
          )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
            ),
          ),
          isLeading
              ? const SizedBox()
              : Icon(
            Icons.arrow_forward_ios,
            color: arrowColor,
            size: 18,
          ),
        ],
      ),
    );
  }
}

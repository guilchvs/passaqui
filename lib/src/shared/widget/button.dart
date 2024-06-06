// import 'package:flutter/material.dart';
// 
// class PassaquiButton extends StatelessWidget {
// 
//   final String label;
//   final Function()? onTap;
//   final Size? minimumSize;
//   final bool isLight;
// 
//   const PassaquiButton({
//     required this.label,
//     this.onTap,
//     this.minimumSize,
//     this.isLight = true,
//     super.key
//   });
// 
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//           style: ButtonStyle(
//             minimumSize: minimumSize != null ? WidgetStatePropertyAll(minimumSize) : null,
//             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 )
//             ),
//             backgroundColor: WidgetStateProperty.resolveWith<Color>(
//                   (Set<WidgetState> states) {
//                 if (states.contains(WidgetState.disabled)) {
//                   return isLight ? const Color(0xFF136048).withOpacity(.25) : const Color(0xFFA8CA4B).withOpacity(.25);
//                 }
//                 else{
//                   return isLight ? const Color(0xFF136048) : const Color(0xFFA8CA4B);
//                 }
//               },
//             ),
// 
//           ),
//           onPressed: onTap,
//           child: Text(
//             label,
//             style: const TextStyle(
//                 fontFamily: 'Raleway',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//                 color: Colors.white
//             ),
//           )
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PassaquiButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Size? minimumSize;
  final bool isLight;
  final bool showArrow;

  const PassaquiButton({
    required this.label,
    this.onTap,
    this.minimumSize,
    this.isLight = true,
    this.showArrow = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, 
      width: 350,
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: minimumSize != null ? MaterialStateProperty.all(minimumSize!) : null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return isLight ? const Color(0xFF136048).withOpacity(0.25) : const Color(0xFFA8CA4B).withOpacity(0.25);
              } else {
                return const Color(0xFFA8CA4B); 
              }
            },
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xFF202020),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward,
                color: const Color(0xFF202020),
              ),
          ],
        ),
      ),
    );
  }
}


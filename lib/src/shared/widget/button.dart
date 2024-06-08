import 'package:flutter/material.dart';

enum PassaquiButtonStyle { primary, secondary, defaultLight, defaultDark }

class PassaquiButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Size? minimumSize;
  final PassaquiButtonStyle style;
  final bool showArrow;
  final bool centerText;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? textColor;
  final Color? iconColor;
  final double? arrowSize; // Optional arrow size parameter

  const PassaquiButton({
    required this.label,
    this.onTap,
    this.minimumSize,
    this.style = PassaquiButtonStyle.defaultLight,
    this.showArrow = false,
    this.centerText = false,
    this.width = 350,
    this.height = 60,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.textColor,
    this.iconColor,
    this.arrowSize, // Arrow size parameter
    Key? key,
  }) : super(key: key);

  ButtonStyle _getButtonStyle() {
    switch (style) {
      case PassaquiButtonStyle.primary:
        return ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color.fromRGBO(18, 96, 73, 1)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          minimumSize: MaterialStateProperty.all<Size>(minimumSize ?? const Size(0, 0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      case PassaquiButtonStyle.secondary:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Color.fromRGBO(168, 202, 75, 1), width: 2),
            ),
          ),
        );
      case PassaquiButtonStyle.defaultDark:
        return ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(minimumSize ?? const Size(0, 0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color(0xFFA8CA4B).withOpacity(0.25);
              } else {
                return const Color(0xFFA8CA4B);
              }
            },
          ),
        );
      case PassaquiButtonStyle.defaultLight:
      default:
        return ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(minimumSize ?? const Size(0, 0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color(0xFF136048).withOpacity(0.25);
              } else {
                return const Color(0xFFA8CA4B);
              }
            },
          ),
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (style) {
      case PassaquiButtonStyle.primary:
      case PassaquiButtonStyle.secondary:
        return TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight, // Use the parameter
          fontSize: fontSize, // Use the parameter
          color: textColor ?? Colors.white, // Use textColor if provided, else default to white
        );
      default:
        return TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight, // Use the parameter
          fontSize: fontSize, // Use the parameter
          color: textColor ?? Color(0xFF202020), // Use textColor if provided, else default
        );
    }
  }

  Icon _getIconStyle() {
    switch (style) {
      case PassaquiButtonStyle.primary:
      case PassaquiButtonStyle.secondary:
        return Icon(
          Icons.arrow_forward,
          color: iconColor ?? Colors.white, // Use iconColor if provided, else default to white
          size: arrowSize ?? 24, // Use arrowSize if provided, else default to 24
        );
      default:
        return Icon(
          Icons.arrow_forward,
          color: iconColor ?? Color(0xFF202020), // Use iconColor if provided, else default
          size: arrowSize ?? 24, // Use arrowSize if provided, else default to 24
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: _getButtonStyle(),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: centerText
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: _getTextStyle(),
            ),
            if (showArrow)
              _getIconStyle(),
          ],
        ),
      ),
    );
  }
}


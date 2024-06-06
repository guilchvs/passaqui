import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Size? minimumSize;
  final bool isSecondary;

  const WelcomeButton(
      {required this.label,
      this.onTap,
      this.minimumSize,
      this.isSecondary = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = isSecondary ? secondaryButtonStyle : primaryButtonStyle;

    return SizedBox(
      width: 350,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ElevatedButton(
            style: buttonStyle,
            onPressed: onTap,
            child: Text(
              label,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white),
            )),
      ),
    );
  }
}

final ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor:
      WidgetStateProperty.all<Color>(const Color.fromRGBO(18, 96, 73, 1)),
  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  minimumSize: WidgetStateProperty.all<Size>(const Size(0, 0)),
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);

final ButtonStyle secondaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all<Color>(
      Colors.transparent), // Set background color to transparent
  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  overlayColor: WidgetStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(color: Color.fromRGBO(168, 202, 75, 1), width: 2),
    ),
  ),
);

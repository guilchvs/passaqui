import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassaquiHideText extends StatefulWidget {
  final bool isVisible;
  final Function()? toggleVisibility;
  final String value;

  const PassaquiHideText(
      {super.key,
        this.isVisible = true,
        this.value = "",
        this.toggleVisibility});

  @override
  State<PassaquiHideText> createState() => _PassaquiHideTextState();
}

class _PassaquiHideTextState extends State<PassaquiHideText> {
  bool showInfo = false;

  final String hideText = "******";

  @override
  void initState() {
    showInfo = widget.isVisible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              r"R$",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          showInfo ? widget.value : hideText,
          style: GoogleFonts.roboto(
              color: Colors.black, fontSize: 36, fontWeight: FontWeight.w500),
        ),
        IconButton(
            onPressed: () {
              widget.toggleVisibility?.call();
              setState(() {
                showInfo = !showInfo;
              });
            },
            icon: Icon(
                showInfo ? Icons.visibility_off_outlined : Icons.visibility))
      ],
    );
  }
}

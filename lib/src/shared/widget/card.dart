import 'package:flutter/material.dart';

class PassaquiCard extends StatelessWidget {

  final Widget content;
  final double? height;

  const PassaquiCard({
    super.key,
    required this.content,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFA8CA4B),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5151511F).withOpacity(0.12),
            offset: Offset(0,2),
            blurRadius: 2
          )
        ]
      ),
      child: content,
    );
  }
}

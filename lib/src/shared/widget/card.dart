import 'package:flutter/material.dart';

class PassaquiCard extends StatelessWidget {
  final Widget content;
  final double? height;
  final Color? backgroundColor; // New line

  const PassaquiCard({
    Key? key, // Changed to Key?
    required this.content,
    this.height,
    this.backgroundColor = const Color(0xFFA8CA4B), // Default color added
  }) : super(key: key); // Fixed super.key

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor, // Updated to use backgroundColor
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5151511F).withOpacity(0.12),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: content,
    );
  }
}


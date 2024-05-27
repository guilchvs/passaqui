import 'package:flutter/material.dart';

class PassaquiTextButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final bool isLeading;

  const PassaquiTextButton({
    super.key,
    required this.label,
    this.isLeading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          isLeading
              ? Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFA8CA4B),
                  size: 18,
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5D5D5DB2)),
            ),
          ),
          isLeading
              ? const SizedBox()
              : Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFA8CA4B),
                  size: 18,
                ),
        ],
      ),
    );
  }
}

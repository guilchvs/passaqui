import 'package:flutter/material.dart';

class PassaquiLink extends StatelessWidget {

  final String label;
  final Function onTap;


  const PassaquiLink({
    required this.label,
    required this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap.call();
      },
      child: Text(label,
        style: const TextStyle(
            color: Color(0xFFA8CA4C),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline
        ),
      ),
    );
  }
}
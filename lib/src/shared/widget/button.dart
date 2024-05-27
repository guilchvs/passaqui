import 'package:flutter/material.dart';

class PassaquiButton extends StatelessWidget {

  final String label;
  final Function()? onTap;
  final Size? minimumSize;
  final bool isLight;

  const PassaquiButton({
    required this.label,
    this.onTap,
    this.minimumSize,
    this.isLight = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: minimumSize != null ? MaterialStatePropertyAll(minimumSize) : null,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return isLight ? Color(0xFF136048).withOpacity(.25) : Color(0xFFA8CA4B).withOpacity(.25);
                }
                else{
                  return isLight ? Color(0xFF136048) : Color(0xFFA8CA4B);
                }
              },
            ),

          ),
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white
            ),
          )
      ),
    );
  }
}
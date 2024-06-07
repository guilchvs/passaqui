import 'package:flutter/material.dart';

class PassaquiTextField extends StatelessWidget {
  final String? label;
  final String placeholder;
  final bool showVisibility;
  final bool isVisible;
  final VoidCallback? toggleVisibility;
  final TextEditingController editingController;
  final Function(String)? onChange;

  const PassaquiTextField({
    this.label,
    required this.editingController,
    this.placeholder = "",
    this.showVisibility = false,
    this.isVisible = true,
    this.toggleVisibility,
    this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF484C4F),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(height: 8),
          TextField(
            controller: editingController,
            onChanged: onChange,
            obscureText: !isVisible,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              suffixIcon: !showVisibility
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: toggleVisibility,
                      child: Icon(
                        isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.white,
                      ),
                    ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFA8CA4B),
                  width: 2.0,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFA8CA4B),
                  width: 1.0,
                ),
              ),
              filled: false,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 60.51 / 50,
                color: Colors.white,
              ),
              hintText: placeholder,
            ),
          ),
        ],
      ),
    );
  }
}


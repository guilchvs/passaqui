import 'package:flutter/material.dart';

class PassaquiTextField extends StatelessWidget {
  final String? label;
  final String placeholder;
  final bool showVisibility;
  final bool isVisible;
  final TextInputType? keyBoardType;
  final VoidCallback? toggleVisibility;
  final TextEditingController editingController;
  final Function(String)? onChange;
  final Color? placeholderColor; // Optional placeholder color
  final Color? textColor; // Optional text color
  final int? maxLength; // Optional maximum length of characters

  const PassaquiTextField({
    this.label,
    required this.editingController,
    this.placeholder = "",
    this.showVisibility = false,
    this.keyBoardType,
    this.isVisible = true,
    this.toggleVisibility,
    this.onChange,
    this.placeholderColor,
    this.textColor, // Accept text color as parameter
    this.maxLength, // Accept maximum length of characters
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
            keyboardType: keyBoardType,
            controller: editingController,
            onChanged: onChange,
            obscureText: !isVisible,
            maxLength: maxLength, // Set maximum length if provided
            style: TextStyle(
              fontSize: 16,
              color: textColor ??
                  Colors.white, // Use provided text color or default white
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              counterText: '', // Remove counter text from default behavior
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
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: placeholderColor ??
                    Colors.grey, // Use provided color or default grey
              ),
              hintText: placeholder,
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

class PassaquiTextField extends StatelessWidget {

  final String label;
  final bool showVisibility;
  final bool isVisible;
  final Function? toggleVisibility;
  final TextEditingController editingController;
  final Function(String)? onChange;

  const PassaquiTextField({
    required this.label,
    required this.editingController,
    this.showVisibility = false,
    this.isVisible = true,
    this.toggleVisibility,
    this.onChange,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF484C4F),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8,),
          TextField(
            controller: editingController,
            onChanged: onChange,
            obscureText: !isVisible,
            decoration: InputDecoration(
              suffixIcon: !showVisibility ? const SizedBox() : GestureDetector(
                child: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "",
              fillColor: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}

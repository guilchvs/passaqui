import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/link.dart';

class PassaquiCheckBox extends StatelessWidget {

  final String label;
  final Function(bool?) onChanged;
  final ValueNotifier<bool> value;

  const PassaquiCheckBox({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: value,
        builder: (context, currentValue, _){
          return  GestureDetector(
            onTap: (){
              onChanged(!currentValue);
            },
            child: Row(
              children: [
                Checkbox(
                  activeColor: const Color(0xFF136048),
                    value: currentValue,
                    onChanged: onChanged
                ),
                PassaquiLink(
                  label: label,
                  onTap: (){
                    onChanged(!currentValue);
                  },
                )
              ],
            ),
          );
        }
    );
  }
}


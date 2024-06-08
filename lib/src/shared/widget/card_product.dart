import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class PassaquiProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback? onPressed;

  const PassaquiProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Image.asset(
              imagePath,
              height: 22,
              width: 22,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            PassaquiButton(
              label: "Continue",
              showArrow: true,
              height: 30,
              width: 240,
              fontSize: 12,
              onTap: () {
                //handle tap
              },
            ),
          ],
        ),
      ),
    );
  }
}

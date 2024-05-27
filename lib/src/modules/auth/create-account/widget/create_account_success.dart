import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class CreateAccountSuccess extends StatelessWidget {
  const CreateAccountSuccess._({super.key});

  static showSuccessFeedback({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26.0)),
        ),
        builder: (context) {
          return const CreateAccountSuccess._();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(26.0),
            topLeft: Radius.circular(26.0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Sua conta foi criada com sucesso",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF136048),
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset("assets/images/account_created_success.svg"),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Em breve você receberá um e-mail para confirmar sua conta.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF136048),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 66,
            ),
            PassaquiButton(
              label: "Ir para login",
            ),
            SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom + 24,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  static const String route = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24,),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26)
                ),
                color: Theme.of(context).highlightColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}



class PassaquiAppBar extends StatelessWidget implements PreferredSizeWidget{
  const PassaquiAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(r"Pa$$ aqui"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

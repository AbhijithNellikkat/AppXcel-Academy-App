import 'package:flutter/material.dart';

class AccountCheckWidget extends StatelessWidget {
  const AccountCheckWidget(
      {super.key, required this.login, required this.press});

  final bool login;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Text(login ? "Don't have an Account ? " : "Already have an Account ? "),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Create Account" : "LogIn",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
        ),
      ],
    );
  }
}

import 'package:appxcel_academy/auth/login.dart';
import 'package:appxcel_academy/auth/signup.dart';
import 'package:appxcel_academy/widgets/features/accout_check/account_check_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../widgets/global/input_field_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Forget Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Lottie.asset(
                      'assets/animations/forget_password_animation.json'),
                  const SizedBox(height: 20),
                  InputFieldWidget(
                    lableText: 'Email',
                    icon: Icons.email,
                    obscureText: false,
                    textEditingController: emailController,
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () async {
                      try {
                        await auth.sendPasswordResetEmail(
                            email: emailController.text);
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Password reset email has been sent !')));
                      } on FirebaseAuthException catch (e) {
                        Fluttertoast.showToast(msg: "$e");
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Text('Sent Link'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: const Text('Create Account')),
                  const SizedBox(height: 50),
                  AccountCheckWidget(
                    login: false,
                    press: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:appxcel_academy/auth/forget_password.dart';
import 'package:appxcel_academy/auth/signup.dart';
import 'package:appxcel_academy/pages/home/home_screen.dart';
import 'package:appxcel_academy/widgets/features/accout_check/account_check_widget.dart';
import 'package:appxcel_academy/widgets/global/input_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                const Text(
                  "AppXcel Academy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 60,
                ),
                Column(
                  children: [
                    InputFieldWidget(
                      lableText: 'Email',
                      icon: Icons.email,
                      obscureText: false,
                      textEditingController: emailController,
                    ),
                    const SizedBox(height: 20),
                    InputFieldWidget(
                      lableText: 'password',
                      icon: Icons.lock,
                      obscureText: true,
                      textEditingController: passwordController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Text(
                        'Forget Password ? ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple),
                      ),
                      onTap: () {
                        // Forget password
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPasswordScreen(),
                            ));
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () async {
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: emailController.text.trim().toLowerCase(),
                          password: passwordController.text.trim());
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: Text('Login'),
                  ),
                ),
                const SizedBox(height: 50),
                AccountCheckWidget(
                  login: true,
                  press: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:appxcel_academy/widgets/global/input_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () async{
                      // try {
                      //   await _auth
                      // } catch (e) {
                        
                      // }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Text('Login'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

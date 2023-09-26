import 'package:flutter/material.dart';

class UpdateStudentScreen extends StatelessWidget {
  const UpdateStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
    ));
  }
}

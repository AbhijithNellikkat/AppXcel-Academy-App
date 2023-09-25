import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/global/input_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    void showImageDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Please choose an option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    getFormCamera(context);
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.camera),
                      ),
                      Text('camera'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    getFormGallery(context);
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.image),
                      ),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: showImageDialog,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: imageFile == null
                        ? const AssetImage("assets/images/notUser.jpg")
                        : Image.file(imageFile!).image,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    InputFieldWidget(
                      lableText: 'Enter Username',
                      icon: Icons.person,
                      obscureText: false,
                      textEditingController: fullNameController,
                    ),
                    const SizedBox(height: 20),
                    InputFieldWidget(
                      lableText: 'Enter Email',
                      icon: Icons.email_rounded,
                      obscureText: false,
                      textEditingController: emailController,
                    ),
                    InputFieldWidget(
                      lableText: 'Enter password',
                      icon: Icons.lock,
                      obscureText: true,
                      textEditingController: passwordController,
                    ),
                    const SizedBox(height: 20),
                    InputFieldWidget(
                      lableText: 'Enter Phone Number',
                      icon: Icons.phone,
                      obscureText: false,
                      textEditingController: passwordController,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getFormCamera(cxt) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    cropImage(pickedFile!.path);
    Navigator.pop(cxt);
  }

  void getFormGallery(cxt) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    cropImage(pickedFile!.path);
    Navigator.pop(cxt);
  }

  void cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }
}

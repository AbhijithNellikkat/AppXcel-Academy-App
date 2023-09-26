// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:appxcel_academy/auth/login.dart';
import 'package:appxcel_academy/pages/home/home_screen.dart';
import 'package:appxcel_academy/widgets/features/accout_check/account_check_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/assets.dart';
import '../widgets/global/input_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  File? imageFile;

  String? imageUrl;

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
                        ? const AssetImage(notUserImage)
                        : Image.file(imageFile!).image,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    InputFieldWidget(
                      lableText: 'Enter teacher name',
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
                      textEditingController: phoneNumberController,
                    ),
                    const SizedBox(height: 50),
                    OutlinedButton(
                      onPressed: () async {
                        if (imageFile == null) {
                          Fluttertoast.showToast(msg: "Please select an Image");
                          return;
                        }
                        try {
                          // ======================================

                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('user Images')
                              .child('${DateTime.now()}.jpg');

                          await ref.putFile(imageFile!);
                          imageUrl = await ref.getDownloadURL();

                          // ======================================

                          await auth.createUserWithEmailAndPassword(
                              email: emailController.text.trim().toLowerCase(),
                              password: passwordController.text.trim());

                          final User? user = auth.currentUser;
                          final uid = user!.uid;
                           final String? token = await FirebaseMessaging.instance.getToken();
                           
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(uid)
                              .set(
                            {
                              'id': uid,
                              'name': fullNameController.text,
                              'email': emailController.text,
                              'phoneNumber': phoneNumberController.text,
                              'userImage': imageUrl,
                              'createAt': Timestamp.now(),
                              'token':token,
                            },
                          );

                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null;

                          fullNameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          phoneNumberController.clear();

                          // ======================================
                        } catch (e) {
                          Fluttertoast.showToast(msg: "$e");
                        }

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: Text('Create Account'),
                      ),
                    ),
                    const SizedBox(height: 50),
                    AccountCheckWidget(
                      login: false,
                      press: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                    )
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

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/global/input_field_widget.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController placeController = TextEditingController();

  File? imageFile;

  String? imageUrl;

  String? userImage;
  String? username;

  @override
  void initState() {
    super.initState();
    readUserInfo();
  }

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
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                const Text(
                  "Add new Student",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 10),
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
                      lableText: 'Enter student name',
                      icon: Icons.person,
                      obscureText: false,
                      textEditingController: nameController,
                    ),
                    const SizedBox(height: 20),
                    InputFieldWidget(
                      lableText: 'Enter student age',
                      icon: Icons.data_saver_off_sharp,
                      obscureText: false,
                      textEditingController: ageController,
                    ),
                    InputFieldWidget(
                      lableText: 'Enter student phone number',
                      icon: Icons.phone,
                      obscureText: false,
                      textEditingController: phoneNumberController,
                    ),
                    const SizedBox(height: 20),
                    InputFieldWidget(
                      lableText: 'Enter student email id',
                      icon: Icons.email,
                      obscureText: false,
                      textEditingController: emailController,
                    ),
                    InputFieldWidget(
                      lableText: 'Enter student place',
                      icon: Icons.location_on_outlined,
                      obscureText: false,
                      textEditingController: placeController,
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                      onPressed: () {
                        uploadImage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: Text('Add Student'),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uploadImage() async {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: "Please select an Image");
      return;
    }

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('studentImages')
          .child("${DateTime.now()}.jpg");
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('studetDetails')
          .doc(DateTime.now().toString())
          .set(
        {
          'id': auth.currentUser!.uid,
          'username': username,
          'userEmail': auth.currentUser!.email,
          'userProfilePic': userImage,
          'studentImage': imageUrl,
          'studentName': nameController.text,
          'studentAge': ageController.text,
          'studentPhoneNumber': phoneNumberController.text,
          'studentEmailId': emailController.text,
          'studentPlace': placeController.text,
          'createAt': DateTime.now(),
        },
      );

      // ignore: use_build_context_synchronously
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

// =========================================================================

  void readUserInfo() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then<dynamic>(
      (DocumentSnapshot snapshot) async {
        userImage = snapshot.get('userImage');
        username = snapshot.get('name');
      },
    );
  }

// =========================================================================

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

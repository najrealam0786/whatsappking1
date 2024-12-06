import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'bottom_navigation_bar.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  String? _errorText;
  final ImagePicker _picker = ImagePicker();
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = 'profilePics/${_user!.uid}.jpg';
      TaskSnapshot snapshot =
      await FirebaseStorage.instance.ref(fileName).putFile(image);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _saveUserData(String name, String photoUrl) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_user!.uid).set({
        'name': name,
        'photoUrl': photoUrl,
        'uid': _user!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  void _validateAndProceed() async {
    if (_nameController.text.isEmpty) {
      setState(() {
        _errorText = 'Please enter your name';
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    String name = _nameController.text.trim();
    String? photoUrl;

    if (_image != null) {
      photoUrl = await _uploadImage(_image!);
    }

    if (photoUrl != null || _image == null) {
      await _saveUserData(name, photoUrl ?? '');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Bottomnavigationbar()),
      );
    } else {
      print("Failed to upload photo.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Profile info',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Please provide your name and an optional profile photo',
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Take a Photo'),
                          onTap: () {
                            _pickImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo),
                          title: Text('Select from Gallery'),
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[100],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.grey[500],
                )
                    : null,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Type your name here',
                errorText: _errorText,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _validateAndProceed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

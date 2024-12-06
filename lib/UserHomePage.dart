import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ContactsScreen.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        backgroundColor: Colors.green,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            onPressed: () {
              print("Camera icon pressed");
            },
          ),

          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              print("More vert icon pressed");
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Search Text Field Below AppBar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.red, Colors.blue, Colors.green],
                    stops: [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.radio_button_off,
                    size: 40,
                    color: Colors.white, // Important: Keep this color to show gradient
                  ),
                ),
                hintText: 'Ask Meta Al or Search',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          // Rest of the body content
          const Expanded(
            child: Center(
              child: Text(
                'Home Page',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_comment_sharp, color: Colors.white, size: 30),
      ),
    );
  }
}

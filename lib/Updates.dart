import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SettingsPage.dart';


class Updates extends StatefulWidget {
  const Updates({super.key});

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          _photoUrl = userDoc['photoUrl'];
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Updates',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
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
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              print("Search icon pressed");
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Profile Photo, "My Status" text and "+" icon
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: _photoUrl != null
                          ? NetworkImage(_photoUrl!)
                          : AssetImage('assets/default_profile.jpg') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Status',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Top to add Status Update',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20), // Space between "Status Update" and updates text

            // Updates Text
            const Text(
              'Updates',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Updates()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
      ),
    );
  }
}

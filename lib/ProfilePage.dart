import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
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
    User? user = FirebaseAuth.instance.currentUser;

    // If user is null, return a loading or error screen
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    // Google login may not have phone number
    String? phoneNumber = user.phoneNumber ?? 'Phone number not available'; // For Google login, phone will be null

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18, // Small profile photo next to title
              backgroundImage: _photoUrl != null
                  ? NetworkImage(_photoUrl!)
                  : NetworkImage(user.photoURL ?? ""),
            ),
            const SizedBox(width: 10), // Space between photo and title
            const Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: _photoUrl != null
                        ? NetworkImage(_photoUrl!)
                        : const AssetImage('assets/default_profile.jpg') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Name: ${user.displayName ?? 'No Name'}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Email: ${user.email ?? 'No Email'}", style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Display the phone number if available, else show a placeholder text
              Text(
                "Phone: $phoneNumber", // Will show "Phone number not available" for Google login users
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

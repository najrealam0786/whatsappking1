import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ProfilePage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _photoUrl;
  String? _userName;

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
          _userName = userDoc['name'];
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
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              print("Search icon pressed");
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // User Profile Section
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: _photoUrl != null
                          ? NetworkImage(_photoUrl!)
                          : const AssetImage('assets/default_profile.jpg')
                      as ImageProvider,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userName ?? 'My Status',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,


                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap to view or edit profile',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Settings Options
          const SettingsOption(
            title: 'Account',
            subtitle: 'Security notifications, change number',
            icon: Icons.lock,
          ),
          const SettingsOption(
            title: 'Privacy',
            subtitle: 'Block contacts, disappearing messages',
            icon: Icons.lock_outline,
          ),
          const SettingsOption(
            title: 'Avatar',
            subtitle: 'Create, edit, profile photo',
            icon: Icons.person_outline,
          ),
          const SettingsOption(
            title: 'Lists',
            subtitle: 'Manage people and groups',
            icon: Icons.list,
          ),
          const SettingsOption(
            title: 'Chats',
            subtitle: 'Theme, wallpapers, chat history',
            icon: Icons.chat,
          ),
          const SettingsOption(
            title: 'Notifications',
            subtitle: 'Message, group & call tones',
            icon: Icons.notifications,
          ),
          const SettingsOption(
            title: 'Storage and data',
            subtitle: 'Network usage, auto-download',
            icon: Icons.storage,
          ),
          const SettingsOption(
            title: 'App language',
            subtitle: 'English (device\'s language)',
            icon: Icons.language,
          ),
          const SettingsOption(
            title: 'Help',
            subtitle: 'Help center, contact us, privacy policy',
            icon: Icons.help_outline,
          ),
        ],
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const SettingsOption({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
      onTap: () {
        print('$title tapped');
      },
    );
  }
}

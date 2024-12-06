import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_contacts/properties/phone.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen();

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Contact> _contacts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.green,
        centerTitle: false,
          actions: [
      IconButton(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onPressed: () {
        print("More vert icon pressed");
      },
    ),
            IconButton(
                icon: const Icon(Icons.search,color: Colors.white),
            onPressed: (){
                  print("Search icon pressed");
            },)
  ]
    ),

      body: SafeArea(
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : _contacts.isEmpty
            ? const Center(
          child: Text('No contacts found'),
        )
            : ListView.builder(
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            Contact contact = _contacts[index];
            final List<Phone> phones = contact.phones;
            return ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(contact.displayName),
              subtitle: Text(
                phones.isEmpty
                    ? "No phone number"
                    : '${phones[0].label}: ${phones[0].number}',
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // User चाहे तो manually भी contacts fetch कर सकता है।
          _fetchContacts();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final PermissionStatus permissionStatus = await Permission.contacts.request();

      if (permissionStatus == PermissionStatus.granted) {
        final contacts = await FlutterContacts.getContacts(withProperties: true);
        setState(() {
          _contacts.clear();
          _contacts.addAll(contacts);
        });
      } else {
        _showPermissionDeniedDialog();
      }
    } catch (e) {
      _showErrorDialog('Error fetching contacts: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Contacts permission is required to fetch contacts. '
              'Please enable it in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

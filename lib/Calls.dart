import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ContactsScreen.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Calls',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.green,
        centerTitle: false,
        actions: [
          IconButton(
            icon:const Icon(Icons.camera_alt,color: Colors.white),
            onPressed: (){
              print("camera icon pressed");
            },
          ),
          IconButton( icon: const Icon(Icons.search,color: Colors.white),
            onPressed: (){
              print("Search icon pressed");
            },
          ),
          IconButton( icon:const Icon(Icons.more_vert,color: Colors.white),
            onPressed: (){
              print("More vert icon pressed");
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'Calls',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Calls()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.call, color: Colors.white, size: 30),
      ),
    );

  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatsappking1/user%20name.dart';
import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful!')),
      );
      // Navigate to HomePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>UserName()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-In Cancelled by User')),
        );
        return; // User canceled the sign-in.
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Successful!')),
      );

      // Navigate to UserHomePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserName()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade300, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Login Form
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Login Text
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google Sign-In Button
                      ElevatedButton(
                        onPressed: () => _googleSignIn(context),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), // Circular shape
                          padding: EdgeInsets.all(20), // Padding for button size
                          // backgroundColor: Colors.red, // Button color
                          //foregroundColor: Colors.white, // Icon color
                        ),
                        child: Image.asset(
                          'asset/google.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 30),
                      // Login Button
                      ElevatedButton(
                        onPressed: () => _login(context),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(24),
                          backgroundColor: Colors.green,
                        ),
                        child: Icon(Icons.arrow_forward, size: 24, color: Colors.white,),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Register Text
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

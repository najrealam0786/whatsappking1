import 'package:flutter/material.dart';


import 'LoginScreen.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),

            Image.asset(
              'asset/whatsapp.jpg',
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to WhatsApp",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text.rich(
                  TextSpan(
                    text: "Read our ",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: ". Tap 'Agree and continue' to accept the ",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: ".",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                )

            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.language, color: Colors.grey),
                  SizedBox(width: 5),
                  Text("English", style: TextStyle(color: Colors.grey)),
                  Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Agree and continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home/SearchCatalogScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(), // Your main screen
      '/search_catalog': (context) => SearchCatalogScreen(), // Target screen
    },
  ));
}


// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Gradient Overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://res.cloudinary.com/dximv3qrs/image/upload/v1741113536/house_image_1_wrf11v.png"),  // Add image to assets folder
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.9), // Dark shade at top
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.7),
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.9), // Dark shade at bottom
                ],
              ),
            ),
          ),

          // UI Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Menu Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Homzes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        // ignore: deprecated_member_use
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: Icon(Icons.menu, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Title Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                  alignment: Alignment.center, // Moves text to center
                  child: Text(
                    "Find the best\nplace for you",
                    textAlign: TextAlign.center, // Centers the text
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ),

                const SizedBox(height: 20),

                // Buttons Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOptionButton(Icons.chair, "Rent", Colors.orange[100]!),
                      _buildOptionButton(Icons.apartment, "Buy", Colors.yellow[100]!),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Create Account Button
                Center(
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/search_catalog');
    },
    child: Text(
      "Create an account",
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  ),
),


                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(IconData icon, String label, Color color) {
    return Container(
      width: 120,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

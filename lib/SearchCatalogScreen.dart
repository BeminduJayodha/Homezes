import 'package:flutter/material.dart';
import 'SearchCatalog3Screen.dart'; // Import the next screen

class SearchCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section (Yellow Background)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Color(0xFFF7F29D), // Light yellow
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, size: 28),
                      Row(
                        children: [
                          Text("Hi, Stanislav",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey[300],
                            child: Text("S", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Featured Section
            _buildSectionHeader(context, "Featured"),

            SizedBox(height: 10),

            // Featured List (Horizontal)
            Container(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildPropertyCard("https://res.cloudinary.com/dximv3qrs/image/upload/v1741113834/house_image_4_m5wbmj.jpg", "\$580", "Rent 3 room apartment"),
                  SizedBox(width: 10),
                  _buildPropertyCard("https://res.cloudinary.com/dximv3qrs/image/upload/v1741113834/house_image_2_x5jjew.jpg", "\$750", "Apartment 4 rooms"),
                  SizedBox(width: 10),
                  _buildPropertyCard("https://res.cloudinary.com/dximv3qrs/image/upload/v1741113835/house_image_3_enaq3s.webp", "\$900", "Apartment in the city center"),
                ],
              ),
            ),

            SizedBox(height: 20),

            // New Offers Section
            _buildSectionHeader(context, "New offers"),

            SizedBox(height: 10),

            // New Offers List (Vertical)
            _buildLargePropertyCard("https://res.cloudinary.com/dximv3qrs/image/upload/v1741113834/house_image_2_x5jjew.jpg", "\$1250", "Apartment 3 rooms", 4.9, 29),
            
          ],
        ),
      ),
    );
  }

  // Function to build section header with "View all"
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500), // Animation duration
                  pageBuilder: (context, animation, secondaryAnimation) => SearchCatalog3Screen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Text("View all", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // Function to build a small horizontal property card
  Widget _buildPropertyCard(String imagePath, String price, String title) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(imagePath, height: 100, width: 160, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(price, style: TextStyle(fontSize: 14, color: Colors.green)),
          ),
        ],
      ),
    );
  }

  // Function to build a large vertical property card
  Widget _buildLargePropertyCard(String imagePath, String price, String title, double rating, int reviews) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(imagePath, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.green, size: 16),
                      SizedBox(width: 4),
                      Text("$rating", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Text("($reviews Reviews)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(price, style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

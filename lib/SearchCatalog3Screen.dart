import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchCatalog3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildTitleSection(),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('properties').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No properties found"));
                  }
                  
                  final properties = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      var property = properties[index].data() as Map<String, dynamic>;
                      return PropertyCard(property: property);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildTopBar() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFC6E7BE),  // Correct color code
      borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30), // Rounded bottom-left corner
      bottomRight: Radius.circular(30), // Rounded bottom-right corner
      ),
    ),
    child: Row(
      children: [
        // Hamburger Menu Icon with Round Background (Smaller Size)
        Container(
          padding: EdgeInsets.all(4), // Reduced padding for a smaller circle
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 3, 3, 3), // Background color
            shape: BoxShape.circle, // Round shape
          ),
          child: IconButton(
            icon: Icon(Icons.menu, size: 24, color: const Color.fromARGB(255, 255, 255, 255)), // Reduced icon size
            onPressed: () {},
          ),
        ),
        
        // Gap between Menu and Search Bar
        SizedBox(width: 16), // Horizontal space between menu and search bar

        // Search Bar
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,  // Set filled to true
              fillColor: Colors.white,  // Set background color to white
              prefixIcon: Icon(Icons.search, color: Colors.grey),  // Put search icon inside the field
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.grey), // Optional: style the hint text
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),  // Rounded corners for search bar
                borderSide: BorderSide.none,  // Removes the border
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0),  // Adjust vertical padding
            ),
          ),
        ),
      ],
    ),
  );
}





  Widget _buildTitleSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      width: double.infinity,
      child: Center(
        child: Text("Popular rent offers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Map<String, dynamic> property;

  PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(property['image'], height: 180, width: double.infinity, fit: BoxFit.cover),
              Positioned(top: 10, right: 10, child: Icon(Icons.favorite_border, color: Colors.white, size: 30)),
              Positioned(
                bottom: 10,
                left: 10,
                child: Row(
                  children: [
                    _buildTag(property['beds']),
                    SizedBox(width: 5),
                    _buildTag(property['baths']),
                  ],
                ),
              ),
            ],
          ),
Padding(
  padding: const EdgeInsets.all(12.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              property['title'] ?? 'No Title', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis, // Prevents overflow
            ),
          ),
          SizedBox(width: 10), // Space between title and price
          Text(
            "\$${property['price'] ?? '0'}/mo",  // Added "/mo" to price
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(height: 4),
      Text(
        property['location'] ?? 'No Location', 
        style: TextStyle(color: Colors.grey),
        overflow: TextOverflow.ellipsis, // Prevents overflow
      ),
    ],
  ),
),

        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

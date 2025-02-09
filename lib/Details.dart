import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Cart_Page.dart';
import 'home.dart';
import 'Profile.dart';

class ProductDetailsPage extends StatefulWidget {
  final String userEmail;

  const ProductDetailsPage({super.key, required this.userEmail});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  int addonQuantity = 0;
  double price = 20.0;
  double addonPrice = 9.0;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(userEmail: widget.userEmail)));
    } else if (index == 1) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CartPage(items: [])));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(loggedInEmail: widget.userEmail)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset('images/chef.png', height: 200),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 5),
                                  Text('4.8',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Text('\$${price.toStringAsFixed(2)}/',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Beef Burger',
                              style: GoogleFonts.poppins(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(
                            'Big Juicy Beef Burger with cheese, lettuce, tomato, onions and special sauce!',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 20),
                          Text('Add Ons',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              _addonItem('images/00.png'),
                              _addonItem('images/001.png'),
                              _addonItem('images/b.png'),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartPage(
                                    items: [
                                      {
                                        'name': 'Beef Burger',
                                        'price': price,
                                        'quantity': quantity
                                      },
                                      {
                                        'name': 'Add-ons',
                                        'price': addonPrice,
                                        'quantity': addonQuantity
                                      }
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Center(
                              child: Text('Add To Cart',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _addonItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.asset(imagePath, height: 50),
          SizedBox(height: 5),
          Icon(Icons.add_circle, color: Colors.green),
        ],
      ),
    );
  }
}

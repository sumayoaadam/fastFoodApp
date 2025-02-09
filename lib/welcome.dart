import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'menu.dart';
import 'order_history.dart';
import 'profile.dart';
import 'cart_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white, size: 30),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => buildMenu(context),
                        );
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Waarid ',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                          TextSpan(
                            text: 'Restaurant',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage(items: [])),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('images/08.png'),
              ),
              SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Enjoy\n',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    TextSpan(
                      text: 'Your Meal!',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(userEmail: "guest@example.com")),
                  );
                },
                child: Text(
                  'Get Started',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userEmail: "guest@example.com"))),
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('Menu'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(onAddToCart: (item) {}))),
          ),
          ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('Orders'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPage())),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(loggedInEmail: "guest@example.com"))),
          ),
        ],
      ),
    );
  }
}

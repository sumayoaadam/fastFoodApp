import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Cart_Page.dart';
import 'profile.dart';
import 'LoginPage.dart';
import 'menu.dart';
import 'order_history.dart';

class HomePage extends StatefulWidget {
  final String userEmail;
  const HomePage({super.key, required this.userEmail});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> popularItems = [
    {'name': 'Burger', 'price': '\$20', 'image': 'images/005.png'},
    {'name': 'Pizza', 'price': '\$30', 'image': 'images/01.png'},
    {'name': 'cocacolla', 'price': '\$15', 'image': 'images/02.png'},
    {'name': 'Fries', 'price': '\$18', 'image': 'images/03.png'},
    {'name': 'Meals', 'price': '\$10', 'image': 'images/08.png'},
    {'name': 'Burger', 'price': '\$12', 'image': 'images/04.png'},

  ];

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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CartPage(items: [])));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MenuPage(onAddToCart: (item) {})));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OrderHistoryPage()));
    } else if (index == 4) {
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
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(loggedInEmail: widget.userEmail)));
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('images/chef.png'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Waarid - Restaurant - App',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 10),
              promoBanner(),
              SizedBox(height: 20),
              Text(
                'Popular',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: popularItems.length,
                itemBuilder: (context, index) {
                  return popularItem(
                      popularItems[index]['name']!,
                      popularItems[index]['price']!,
                      popularItems[index]['image']!);
                },
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget promoBanner() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          'Todays Offer: Free Box of Fries on all orders above \$150',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget popularItem(String name, String price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(imagePath, height: 80),
          SizedBox(height: 10),
          Text(
            name,
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.purple),
          ),
          Icon(Icons.add_circle, color: Colors.green),
        ],
      ),
    );
  }
}

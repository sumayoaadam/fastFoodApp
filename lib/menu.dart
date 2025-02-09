import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Cart_Page.dart';
import 'profile.dart';
import 'LoginPage.dart';
import 'menu.dart';
import 'order_history.dart';

class MenuPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  const MenuPage({super.key, required this.onAddToCart});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> cartItems = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CartPage(items: cartItems)));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MenuPage(onAddToCart: addToCart)));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OrderHistoryPage()));
    } else if (index == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProfilePage(loggedInEmail: 'user@example.com')));
    }
  }

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      int existingIndex = cartItems.indexWhere((cartItem) => cartItem['name'] == item['name']);
      if (existingIndex >= 0) {
        cartItems[existingIndex]['quantity'] += 1;
      } else {
        cartItems.add({...item, 'quantity': 1});
      }
    });
  }

  List<Map<String, dynamic>> menuItems = [
    {'name': 'Burger', 'price': 5.99, 'image': 'images/00.png'},
    {'name': 'pasta_makarooni', 'price': 8.99, 'image': 'images/01.png'},
    {'name': 'cocacolla', 'price': 6.99, 'image': 'images/02.png'},
    {'name': 'Fries', 'price': 2.99, 'image': 'images/03.png'},
    {'name': 'Soda', 'price': 1.99, 'image': 'images/05.png'},
    {'name': 'Burger', 'price': 3.5, 'image': 'images/04.png'},
    {'name': 'chips', 'price': 5.99, 'image': 'images/06.png'},
    {'name': 'meals', 'price': 10.99, 'image': 'images/08.png'},
    {'name': 'Chips_fries', 'price': 2.00, 'image': 'images/07.png'},
    {'name': 'ice_cream', 'price': 1.99, 'image': 'images/09.png'},
    {'name': 'kajab', 'price': 1.99, 'image': 'images/001.png'},
    {'name': 'Burger_large', 'price': 2.5, 'image': 'images/002.png'},
    {'name': 'Fruits', 'price': 1.99, 'image': 'images/003.png'},
    {'name': 'Pasta', 'price': 4.99, 'image': 'images/004.png'},
    {'name': 'Pizza_Medium', 'price': 7.99, 'image': 'images/005.png'},
    {'name': 'juice', 'price': 2.99, 'image': 'images/005.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu',
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(item['image'], height: 100),
                  SizedBox(height: 10),
                  Text(item['name'],
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('\$${item['price'].toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16, color: Colors.purple)),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      addToCart(item);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text('Add to Cart', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

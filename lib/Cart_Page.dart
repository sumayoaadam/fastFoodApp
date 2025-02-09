import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';
import 'home.dart';
import 'menu.dart';
import 'order_history.dart';
import 'profile.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const CartPage({super.key, required this.items});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  int _selectedIndex = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.items);
  }

  double getTotalPrice() {
    return cartItems.fold(0, (total, item) => total + (item['price'] * item['quantity']));
  }

  void updateQuantity(int index, int change) {
    setState(() {
      if (cartItems[index]['quantity'] + change > 0) {
        cartItems[index]['quantity'] += change;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  Future<void> proceedToCheckout() async {
    if (cartItems.isEmpty) return;
    final db = await DatabaseHelper.instance.database;
    for (var item in cartItems) {
      await db.insert('orders', {
        'item_name': item['name'],
        'price': item['price'],
        'quantity': item['quantity'],
      });
    }
    setState(() {
      cartItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order placed successfully!')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrderHistoryPage()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(userEmail: "user@example.com")));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CartPage(items: cartItems)));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MenuPage(onAddToCart: (item) {})));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OrderHistoryPage()));
    } else if (index == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProfilePage(loggedInEmail: "user@example.com")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Your Cart', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: cartItems.isEmpty
                    ? Center(child: Text("Your cart is empty", style: GoogleFonts.poppins(fontSize: 18)))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    item['image'],
                                    height: 60,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item['name'],
                                            style: GoogleFonts.poppins(
                                                fontSize: 18, fontWeight: FontWeight.bold)),
                                        Text('\$${item['price'].toStringAsFixed(2)}',
                                            style: TextStyle(fontSize: 16, color: Colors.purple)),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle, color: Colors.red),
                                        onPressed: () => updateQuantity(index, -1),
                                      ),
                                      Text('${item['quantity']}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 18, fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: Icon(Icons.add_circle, color: Colors.green),
                                        onPressed: () => updateQuantity(index, 1),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.black),
                                        onPressed: () => removeItem(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total: \$${getTotalPrice().toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: proceedToCheckout,
                      child: Center(
                        child: Text('Proceed to Checkout',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
      ),
    );
  }
}

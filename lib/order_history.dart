import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';
import 'Cart_Page.dart';
import 'profile.dart';
import 'LoginPage.dart';
import 'menu.dart';
import 'order_history.dart';
import 'home.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> orders = [];
  int _selectedIndex = 3;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> cartItems = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(userEmail: 'user@example.com')));
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
          context, MaterialPageRoute(builder: (context) => ProfilePage(loggedInEmail: 'user@example.com')));
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  void _initializeDatabase() async {
    final db = await DatabaseHelper.instance.database;
    await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT,
        price REAL,
        quantity INTEGER
      )
    ''');
    _loadOrderHistory();
  }

  void _loadOrderHistory() async {
    final db = await DatabaseHelper.instance.database;
    final orderList = await db.query('orders');
    setState(() {
      orders = orderList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: orders.isEmpty
          ? Center(child: Text('No orders found', style: GoogleFonts.poppins(fontSize: 18)))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(orders[index]['item_name'], style: GoogleFonts.poppins(fontSize: 18)),
                    subtitle: Text('Price: \$${orders[index]['price'].toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)),
                    trailing: Text('Qty: ${orders[index]['quantity']}',
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black)),
                  ),
                );
              },
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

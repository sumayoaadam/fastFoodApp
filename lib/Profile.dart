import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';
import 'Cart_Page.dart';
import 'profile.dart';
import 'LoginPage.dart';
import 'menu.dart';
import 'order_history.dart';
import 'home.dart';
import 'settings.dart';
import 'edit.dart';

class ProfilePage extends StatefulWidget {
  final String loggedInEmail;

  const ProfilePage({super.key, required this.loggedInEmail});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userEmail = "Loading...";
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final db = await DatabaseHelper.instance.database;
    final user = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [widget.loggedInEmail],
    );
    if (user.isNotEmpty) {
      setState(() {
        userEmail = user.first['email'] as String;
      });
    }
  }

  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(userEmail: widget.loggedInEmail)));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CartPage(items: [])));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MenuPage(onAddToCart: (item) {})));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OrderHistoryPage()));
    } else if (index == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProfilePage(loggedInEmail: widget.loggedInEmail)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/chef.png'),
                ),
              ),
              SizedBox(height: 20),
              Text('User Email',
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 10),
              Text(userEmail,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.purple),
                title: Text('Edit Profile',
                    style: GoogleFonts.poppins(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfilePage(email: userEmail)),
                  ).then((_) => _loadUserData());
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.purple),
                title: Text('Order History',
                    style: GoogleFonts.poppins(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.purple),
                title: Text('Settings', style: GoogleFonts.poppins(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Logout',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 4,
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
      ),
    );
  }
}

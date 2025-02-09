import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';

class EditProfilePage extends StatefulWidget {
  final String email;
  const EditProfilePage({super.key, required this.email});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String userImage = "images/default.png";
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final db = await DatabaseHelper.instance.database;
    final user = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [widget.email],
    );
    if (user.isNotEmpty) {
      setState(() {
        emailController.text = user.first['email']?.toString() ?? "";
        nameController.text = user.first['name']?.toString() ?? "Guest";
        userImage = user.first['image']?.toString() ?? "images/chef.png";
      });
    }
  }

  Future<void> _updateUserProfile() async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'users',
      {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'name': nameController.text.trim(),
        'image': userImage,
      },
      where: 'email = ?',
      whereArgs: [widget.email],
    );
    Navigator.pop(context, true);
  }

  Future<void> _pickImage() async {
    // Simulating image selection - replace with actual image picker logic
    setState(() {
      userImage = "images/new_profile.png"; // Assume new image is chosen
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
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
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(userImage),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'New Password', border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: _updateUserProfile,
                child: Text('Update Profile', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

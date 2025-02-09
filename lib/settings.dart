import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isDarkMode = prefs.getBool('darkMode') ?? false;
        selectedLanguage = prefs.getString('language') ?? 'English';
      });
    } catch (e) {
      print("Error loading settings: \$e");
    }
  }

  Future<void> _updateDarkMode(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isDarkMode = value;
        prefs.setBool('darkMode', value);
      });
    } catch (e) {
      print("Error updating dark mode: \$e");
    }
  }

  Future<void> _updateLanguage(String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedLanguage = value;
        prefs.setString('language', value);
      });
    } catch (e) {
      print("Error updating language: \$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.purple,
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.brightness_6, color: Colors.purple),
                title: Text('Dark Mode', style: GoogleFonts.poppins(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black)),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: _updateDarkMode,
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.language, color: Colors.purple),
                title: Text('Language', style: GoogleFonts.poppins(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black)),
                trailing: DropdownButton<String>(
                  dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
                  value: selectedLanguage,
                  items: ['English', 'Spanish', 'French', 'German']
                      .map((language) => DropdownMenuItem(
                            value: language,
                            child: Text(language, style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _updateLanguage(value);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.notifications, color: Colors.purple),
                title: Text('Notifications', style: GoogleFonts.poppins(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black)),
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.lock, color: Colors.purple),
                title: Text('Change Password', style: GoogleFonts.poppins(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black)),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.help, color: Colors.purple),
                title: Text('Help & Support', style: GoogleFonts.poppins(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black)),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

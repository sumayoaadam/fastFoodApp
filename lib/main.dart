import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'Signup.dart';
// import 'home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database; // Ensure database is initialized
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
       home: SignupPage(),
      // home: HomePage(
      //     userEmail:
      //         "guest@example.com"), // Or better, start with LoginPage() instead
    );
  }
}

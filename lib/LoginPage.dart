import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';
import 'signup.dart';
import 'welcome.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF7B1FA2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/002.png',
                height: 80,
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Waarid ',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    TextSpan(
                      text: 'resturent',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF9800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                onPressed: () async {
                final user = await DatabaseHelper.instance.getUser(emailController.text.trim());

if (user != null && user['password'] == passwordController.text.trim()) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => WelcomePage()),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Invalid Email or Password')),
  );
}

                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  ).then((value) async {
                    if (value != null && value is Map<String, String>) {
                      await DatabaseHelper.instance.insertUser({
                        'email': value['email']!,
                        'password': value['password']!
                      });
                      emailController.text = value['email'] ?? '';
                      passwordController.text = value['password'] ?? '';
                    }
                  });
                },
                child: Text(
                  'Not a member? Register here',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SocialLoginButton(
                  'Login with Facebook', Colors.white, 'images/facebook.png'),
              SizedBox(height: 10),
              SocialLoginButton('Login with Google account', Colors.white,
                  'images/google.png'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget SocialLoginButton(String text, Color color, String iconPath) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(iconPath, height: 20),
        SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
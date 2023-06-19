import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/login/login_screen.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({super.key, required this.title});

  final String title;

  @override
  _LoginChoiceState createState() => _LoginChoiceState();
}

class _LoginChoiceState extends State<LoginChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Image.asset('assets/images/logo.png')
              ),

              // Login as Investor
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: ElevatedButton(
                  onPressed:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login(title: 'Investor')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19A7CE),
                      fixedSize: const Size(double.maxFinite, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text(
                    "Masuk Sebagai Investor",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              // Login as UMKM
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: ElevatedButton(
                  onPressed:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login(title: 'UMKM')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19A7CE),
                      fixedSize: const Size(double.maxFinite, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text(
                    "Masuk Sebagai UMKM",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
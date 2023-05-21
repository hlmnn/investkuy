import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/login/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:investkuy/ui/screen/visitor/login_choice_screen.dart';

class VisitorRiwayat extends StatefulWidget {
  const VisitorRiwayat({super.key, required this.title});

  final String title;

  @override
  _VisitorRiwayatState createState() => _VisitorRiwayatState();
}

class _VisitorRiwayatState extends State<VisitorRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Anda belum memasuki akun. Masuk terlebih dahulu!"),
              ElevatedButton(
                onPressed:  ()  {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginChoice(title: 'LoginChoice'))
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff19A7CE),
                    fixedSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                child: const Text(
                  "Klik untuk Masuk",
                  style: TextStyle(
                    fontSize: 18,
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
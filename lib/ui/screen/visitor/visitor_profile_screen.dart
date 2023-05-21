import 'package:flutter/material.dart';

import 'login_choice_screen.dart';

class VisitorProfile extends StatefulWidget {
  const VisitorProfile({super.key, required this.title});

  final String title;

  @override
  _VisitorProfileState createState() => _VisitorProfileState();
}

class _VisitorProfileState extends State<VisitorProfile> {
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle_rounded,
                    size: 70,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginChoice(title: 'LoginChoice'))
                      );
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.login,
                            color: Colors.black,
                          ),
                        ),
                        Text("Klik Untuk Masuk",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Lainnya",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Pusat Bantuan",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Tentang Aplikasi",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
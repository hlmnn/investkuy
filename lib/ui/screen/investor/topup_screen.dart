import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/register/register_screen.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key, required this.title});

  final String title;

  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xffE4F9FF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cara Bayar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('Anda hanya perlu melakukan pembayaran  via ATM, internet banking, atau Virtual Account berikut:'),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              color: const Color(0xff90E7FF),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const Text(
                            '1234567890',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.copy_outlined),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
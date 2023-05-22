import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/register/register_screen.dart';

class HistoryWithdraw extends StatefulWidget {
  const HistoryWithdraw({super.key, required this.title});

  final String title;

  @override
  _HistoryWithdrawState createState() => _HistoryWithdrawState();
}

class _HistoryWithdrawState extends State<HistoryWithdraw> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xffE4F9FF),
              elevation: 2.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Padding (
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Saldo yang ditarik'),
                          Text('Rp1.XXX.XXX',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Tanggal Wihdraw'),
                          Text('XX/XX/XXXX',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text('Success',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
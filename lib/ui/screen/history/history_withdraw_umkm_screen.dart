import 'package:flutter/material.dart';

class HistoryWithdrawUmkm extends StatefulWidget {
  const HistoryWithdrawUmkm({super.key, required this.title});

  final String title;

  @override
  _HistoryWithdrawUmkmState createState() => _HistoryWithdrawUmkmState();
}

class _HistoryWithdrawUmkmState extends State<HistoryWithdrawUmkm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
          child: ListView.builder(
            itemCount: 8,
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
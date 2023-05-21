import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/register/register_screen.dart';

class RiwayatInProgress extends StatefulWidget {
  const RiwayatInProgress({super.key, required this.title});

  final String title;

  @override
  _RiwayatInProgressState createState() => _RiwayatInProgressState();
}

class _RiwayatInProgressState extends State<RiwayatInProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 5,  bottom: 5, left: 20, right: 20),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const InvestorDetail(title: 'Detail UMKM'))
                  // );
                },
                child: Card(
                  color: const Color(0xffE4F9FF),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: Padding (
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.account_circle_rounded,
                                  size: 70,
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Padding(padding: EdgeInsets.only(bottom: 6),
                                            child: Text("Nama Pedagang",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(bottom: 6),
                                            child: Text("Sektor UMKM",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(bottom: 6),
                                              child: Text('Alamat UMKM',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              )
                                          ),
                                        ],
                                      )
                                  ),
                                )
                              ],
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: const [
                                        Text("Plafond"),
                                        Text("Rp X.000.000",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Text("Bagi Hasil"),
                                        Text("Rp X.000.000",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Text("Tenor"),
                                        Text("X0 Minggu",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),

                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text("Jumlah Pendanaan"),
                              ),
                              Text(": RpX0.000",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text("Repayment Saat Ini"),
                              ),
                              Text(": RpX0.000",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
            },
          ),
        )
    );
  }
}
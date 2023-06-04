import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/umkm/umkm_detail_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RiwayatCrowdfunding extends StatefulWidget {
  const RiwayatCrowdfunding({super.key, required this.title});

  final String title;

  @override
  _RiwayatCrowdfundingState createState() => _RiwayatCrowdfundingState();
}

class _RiwayatCrowdfundingState extends State<RiwayatCrowdfunding> {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UmkmDetail(title: 'Detail UMKM'))
                  );
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
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Text("Dana Terkumpul"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("RpX0.000.000"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: const ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    child: LinearProgressIndicator(
                                      value: 0.9,
                                      minHeight: 20,
                                      color: Color(0xff19A7CE),
                                      backgroundColor: Color(0xff90E7FF),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text("Tanggal"),
                                  ),
                                  Text(": XX/XX/XXXX",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(" s/d "),
                                  Text("XX/XX/XXXX",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 5,
                                height: 5,
                              ),
                              Row(
                                children: const [
                                  Text("In Progress",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
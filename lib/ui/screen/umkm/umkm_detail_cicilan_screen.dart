import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:investkuy/ui/screen/umkm/umkm_bayar_cicilan_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_daftar_investor_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_laporan_keuangan_screen.dart';

class UmkmDetailCicilan extends StatefulWidget {
  const UmkmDetailCicilan({super.key, required this.title, required this.id});

  final String title;
  final int id;

  @override
  _UmkmDetailCicilanState createState() => _UmkmDetailCicilanState();
}

class _UmkmDetailCicilanState extends State<UmkmDetailCicilan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.account_circle_rounded,
                          size: 70,
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      "Nama Pedagang",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      "Sektor UMKM",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Alamat UMKM',
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      )),
                                ],
                              )),
                        )
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 150.0,
                      viewportFraction: 0.6,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      initialPage: 1,
                    ),
                    items: [1, 2, 3, 4].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration:
                                const BoxDecoration(color: Color(0xffE4F9FF)),
                            child: Center(
                              child: Text(
                                'FOTO $i',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
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
                                Text(
                                  "Rp X.000.000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text("Bagi Hasil"),
                                Text(
                                  "Rp X.00.000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text("Tenor"),
                                Text(
                                  "X0 Minggu",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                    color: const Color(0xffE4F9FF),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tentang UMKM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....')
                      ],
                    )),
                Container(
                    color: const Color(0xffE4F9FF),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Tenor Pendanaan"),
                            Text(
                              "X0 Minggu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Imbal Hasil (%)"),
                            Text(
                              "XX%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Jenis Angsuran"),
                            Text(
                              "Bulanan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Jumlah Angsuran"),
                            Text(
                              "Rp. XX.XXX",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Penghasilan Perbulan"),
                            Text(
                              "Rp.XXX.XXX",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Pekerjaan"),
                            Text(
                              "XXXXXXXX",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Dana Terkumpul"),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "RpX0.000.000",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: LinearProgressIndicator(
                              value: 1,
                              minHeight: 20,
                              color: Color(0xff19A7CE),
                              backgroundColor: Color(0xff90E7FF),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text("Jatuh Tempo"),
                          ),
                          Text(
                            "XX/XX/XXXX",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text("Angsuran"),
                          ),
                          Text(
                            "RpX00.000",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UmkmLaporanKeuangan(
                                title: "Tambah Laporan Keuangan",
                                id: 0)));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19A7CE),
                      fixedSize: const Size(double.maxFinite, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Tambah Laporan Keuangan",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UmkmDaftarInvestor(
                                title: "Daftar Investor",
                                id: 0)));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19A7CE),
                      fixedSize: const Size(double.maxFinite, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Lihat Daftar Investor",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              padding: const EdgeInsets.all(20),
              height: 90,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UmkmBayarCicilan(
                                  title: "Bayar Cicilan")));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff19A7CE),
                        fixedSize: const Size(double.maxFinite, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Bayar Cicilan",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}

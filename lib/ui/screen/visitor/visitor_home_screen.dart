import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/cubit/umkm_home_cubit.dart';
import 'package:investkuy/ui/screen/visitor/visitor_detail_screen.dart';
import 'package:investkuy/ui/screen/visitor/visitor_articles_screen.dart';
import 'package:investkuy/ui/screen/visitor/visitor_faq_screen.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/date_formatter.dart';
import 'package:investkuy/utils/string_format.dart';

class VisitorHome extends StatefulWidget {
  const VisitorHome({super.key, required this.title});

  final String title;

  @override
  _VisitorHomeState createState() => _VisitorHomeState();
}

class _VisitorHomeState extends State<VisitorHome> {
  List<String> bannerImg = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpeg',
  ];

  Future refresh() async {
    BlocProvider.of<UmkmHomeCubit>(context).getRekomendasi();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UmkmHomeCubit>(context).getRekomendasi();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 100.0,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      initialPage: 0,
                    ),
                    items: bannerImg.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration:
                                const BoxDecoration(color: Color(0xffE4F9FF)),
                            child: Image.asset(i, fit: BoxFit.cover),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xffE4F9FF),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(2, 2), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    children: [
                      const Text('Total saldo yang tersedia'),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          CurrencyFormat.convertToIdr(0, 0),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                SnackBar snackBar = const SnackBar(
                                  duration: Duration(seconds: 5),
                                  content: Text(
                                      "Silahkan melakukan login terlebih dahulu."),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                backgroundColor: const Color(0xff90E7FF),
                                fixedSize: const Size(75, 75),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_box_outlined,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "Top Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  SnackBar snackBar = const SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text(
                                        "Silahkan melakukan login terlebih dahulu."),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  backgroundColor: const Color(0xff90E7FF),
                                  fixedSize: const Size(75, 75),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.price_change_outlined,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Withdraw",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                SnackBar snackBar = const SnackBar(
                                  duration: Duration(seconds: 5),
                                  content: Text(
                                      "Silahkan melakukan login terlebih dahulu."),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                backgroundColor: const Color(0xff90E7FF),
                                fixedSize: const Size(75, 75),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sticky_note_2_outlined,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "History",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Faqs(title: 'FAQ'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            backgroundColor: const Color(0xff90E7FF),
                            fixedSize: const Size(75, 75),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu_book_outlined,
                                color: Colors.black,
                                size: 35,
                              ),
                              Text(
                                "FAQ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Articles(title: 'Artikel'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            backgroundColor: const Color(0xff90E7FF),
                            fixedSize: const Size(75, 75),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article_outlined,
                                color: Colors.black,
                                size: 35,
                              ),
                              Text(
                                "Artikel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    "Rekomendasi UMKM",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BlocBuilder<UmkmHomeCubit, DataState>(
                    builder: (context, state) {
                  List<UmkmModel> listRekomendasiUmkm = [];

                  if (state is SuccessState) {
                    listRekomendasiUmkm = state.data;
                  }

                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 250.0,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: false,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        initialPage: 0,
                      ),
                      items: listRekomendasiUmkm.map((umkmItem) {
                        final item = umkmItem;
                        Widget img = const Icon(
                          Icons.account_circle_rounded,
                          size: 70,
                        );
                        if (item.detailPemilik.img != "") {
                          img = CircleAvatar(
                            backgroundImage:
                                NetworkImage(item.detailPemilik.img),
                            radius: 35,
                          );
                        }
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VisitorDetail(
                                      title: 'Detail UMKM',
                                      id: item.id.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: const Color(0xffE4F9FF),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 8.0,
                                                ),
                                                child: img,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 6,
                                                        ),
                                                        child: Text(
                                                          item.detailPemilik
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 6,
                                                        ),
                                                        child: Text(
                                                          StringFormat
                                                              .capitalizeAllWord(
                                                            item.sektor,
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 6,
                                                        ),
                                                        child: Text(
                                                          StringFormat
                                                              .capitalizeAllWord(
                                                            item.detailPemilik
                                                                .alamat,
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    const Text("Plafond"),
                                                    Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                        item.plafond,
                                                        0,
                                                      ),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    const Text("Bagi Hasil"),
                                                    Text(
                                                      "${item.bagiHasil.toString()}%",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    const Text("Tenor"),
                                                    Text(
                                                      "${item.tenor.toString()} Minggu",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const Text("Dana Terkumpul"),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    CurrencyFormat.convertToIdr(
                                                        item.jumlahPendanaan,
                                                        0)),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8)),
                                                  child:
                                                      LinearProgressIndicator(
                                                    value:
                                                        item.jumlahPendanaan /
                                                            item.plafond,
                                                    minHeight: 20,
                                                    color:
                                                        const Color(0xff19A7CE),
                                                    backgroundColor:
                                                        const Color(0xff90E7FF),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Text("Tanggal"),
                                                ),
                                                Text(
                                                  ": ${DateFormatter.convertToDate(item.tanggalMulai)}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Text(" s/d "),
                                                Text(
                                                  DateFormatter.convertToDate(
                                                      item.tanggalBerakhir),
                                                  style: const TextStyle(
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
                        );
                      }).toList(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

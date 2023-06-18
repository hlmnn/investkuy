import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/ui/cubit/umkm_home_cubit.dart';
import 'package:investkuy/ui/screen/history/history_screen.dart';
import 'package:investkuy/ui/screen/history/history_withdraw_screen.dart';
import 'package:investkuy/ui/screen/history/history_withdraw_umkm_screen.dart';
import 'package:investkuy/ui/screen/investor/topup_screen.dart';
import 'package:investkuy/ui/screen/notification/notifikasi_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_ajukan_pendanaan_screen.dart';
import 'package:investkuy/ui/screen/withdraw/withdraw_screen.dart';
import 'package:investkuy/ui/screen/visitor/visitor_articles_screen.dart';
import 'package:investkuy/ui/screen/visitor/visitor_faq_screen.dart';

import '../../../data/data_state.dart';

class UmkmHome extends StatefulWidget {
  const UmkmHome({super.key, required this.title});

  final String title;

  @override
  _UmkmHomeState createState() => _UmkmHomeState();
}

class _UmkmHomeState extends State<UmkmHome> {
  @override
  Widget build(BuildContext context) {
    bool verifiedState = false;
    
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Notifikasi(title: 'Notifikasi')));
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
        ),
        body: BlocBuilder<UmkmHomeCubit, DataState>(
          builder: ((context, state) {
            context.read<UmkmHomeCubit>().getVerifiedState();
            
            if (state is SuccessState<bool>) {
              verifiedState = state.data;
            }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(40),
                        width: double.infinity,
                        color: const Color(0xff90E7FF),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Column(
                          children: [
                            Text(
                              'BANNER',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        color: const Color(0xffE4F9FF),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text('Total saldo yang tersedia (Rp)'),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                '5.000.000',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Withdraw(
                                                    title: 'Withdraw')));
                                  },
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.price_change_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "Withdraw",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HistoryWithdrawUmkm(
                                                    title:
                                                        'History Withdraw')));
                                  },
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.sticky_note_2_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "History",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Faqs(title: 'FAQ')));
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.menu_book_outlined,
                                color: Colors.black,
                                size: 35,
                              ),
                              Text(
                                "FAQ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            
                            if (verifiedState) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UmkmAjukanPendanaan(
                                              title: 'Ajukan Pendanaan')));
                            } else {
                              SnackBar snackBar = const SnackBar(
                                duration: Duration(seconds: 5),
                                content: Text(
                                    "Anda harus melakukan verifikasi akun!"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add_business_outlined,
                                color: Colors.black,
                                size: 35,
                              ),
                              Text(
                                "Ajukan",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        "Rekomendasi Artikel",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                    color: Color(0xffE4F9FF)),
                                child: Center(
                                  child: Text(
                                    'REKOMENDASI\nARTIKEL $i',
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
                  ],
                ),
              ),
            );
          }),
        )
        /*  */
        );
  }
}

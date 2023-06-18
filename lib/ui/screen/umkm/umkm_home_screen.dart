import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/article_model.dart';
import 'package:investkuy/ui/cubit/article_cubit.dart';
import 'package:investkuy/ui/cubit/umkm_home_cubit.dart';
import 'package:investkuy/ui/cubit/wallet_cubit.dart';
import 'package:investkuy/ui/screen/history/history_screen.dart';
import 'package:investkuy/ui/screen/history/history_withdraw_umkm_screen.dart';
import 'package:investkuy/ui/screen/notification/notifikasi_screen.dart';
import 'package:investkuy/ui/screen/topup/topup_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_ajukan_pendanaan_screen.dart';
import 'package:investkuy/ui/screen/visitor/visitor_articles_screen.dart';
import 'package:investkuy/ui/screen/visitor/visitor_faq_screen.dart';
import 'package:investkuy/ui/screen/withdraw/withdraw_screen.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/date_formatter.dart';

class UmkmHome extends StatefulWidget {
  const UmkmHome({super.key, required this.title});

  final String title;

  @override
  _UmkmHomeState createState() => _UmkmHomeState();
}

class _UmkmHomeState extends State<UmkmHome> {
  List<String> bannerImg = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpeg',
  ];

  Future refresh() async {
    BlocProvider.of<WalletCubit>(context).getWallet();
    BlocProvider.of<ArticleCubit>(context).getLimitArticle();
    BlocProvider.of<UmkmHomeCubit>(context).getVerifiedState();
  }

  @override
  Widget build(BuildContext context) {
    bool verifiedState = false;
    BlocProvider.of<WalletCubit>(context).getWallet();
    BlocProvider.of<ArticleCubit>(context).getLimitArticle();
    BlocProvider.of<UmkmHomeCubit>(context).getVerifiedState();

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
                  builder: (context) => const Notifikasi(title: 'Notifikasi'),
                ),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: BlocBuilder<UmkmHomeCubit, DataState>(
        builder: (context, state) {
          if (state is SuccessState<bool>) {
            verifiedState = state.data;
          }
          return RefreshIndicator(
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                            offset: const Offset(
                                2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: BlocBuilder<WalletCubit, DataState>(
                          builder: (context, state) {
                        int id = 0;
                        int balance = 0;
                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SuccessState) {
                          id = state.data.id;
                          balance = state.data.balance;
                        }
                        return Column(
                          children: [
                            const Text('Total saldo yang tersedia'),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                CurrencyFormat.convertToIdr(
                                  balance,
                                  0,
                                ),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TopUp(
                                            title: 'Top Up',
                                            walletId: id,
                                          ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Withdraw(
                                              title: 'Withdraw',
                                              walletId: id,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                        ),
                                        backgroundColor:
                                            const Color(0xff90E7FF),
                                        fixedSize: const Size(75, 75),
                                      ),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => History(
                                            title: 'History',
                                            walletId: id,
                                          ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        );
                      }),
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
                                    builder: (context) =>
                                        const Faqs(title: 'FAQ'),
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
                        "Rekomendasi Artikel",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BlocBuilder<ArticleCubit, DataState>(
                        builder: (context, state) {
                      List<ArticleModel> listRekomendasiArticle = [];

                      if (state is SuccessState) {
                        listRekomendasiArticle = state.data;
                      }

                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 150.0,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: false,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            initialPage: 0,
                          ),
                          items: listRekomendasiArticle.map((itemArticle) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE4F9FF),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                        child: SizedBox(
                                          height: 90,
                                          width: double.maxFinite,
                                          child: Image.network(
                                            itemArticle.imgUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          itemArticle.title,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Tanggal: ${DateFormatter.convertToDate(itemArticle.tglTerbit)}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
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
          );
        },
      ),
    );
  }
}

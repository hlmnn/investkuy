import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/investor/history_screen.dart';
import 'package:investkuy/ui/screen/investor/topup_screen.dart';
import 'package:investkuy/ui/screen/investor/withdraw_screen.dart';

class VisitorHome extends StatefulWidget {
  const VisitorHome({super.key, required this.title});

  final String title;

  @override
  _VisitorHomeState createState() => _VisitorHomeState();
}

class _VisitorHomeState extends State<VisitorHome> {
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
              Container(
                padding: const EdgeInsets.all(40),
                width: double.infinity,
                color: const Color(0xff90E7FF),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: const [
                    Text('BANNER',
                      style: TextStyle(
                        fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ),

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
                        child: Text('0',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TopUp(title: 'Top Up'))
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(Icons.crop_square_sharp,
                                  color: Colors.black,
                                ),
                                Text("Top Up",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Withdraw(title: 'Withdraw'))
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                ),
                                Text("Withdraw",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const History(title: 'History'))
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                ),
                                Text("History",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const History(title: 'History'))
                      // );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.menu_book_outlined,
                          color: Colors.black,
                          size: 35,
                        ),
                        Text("FAQ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const History(title: 'History'))
                      // );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.article_outlined,
                          color: Colors.black,
                          size: 35,
                        ),
                        Text("Artikel",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Rekomendasi UMKM",
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
                  items: [1,2,3,4].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                              color: Color(0xffE4F9FF)
                          ),
                          child: Center(
                            child: Text(
                              'REKOMENDASI UMKM $i',
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
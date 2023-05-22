import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/login/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:investkuy/ui/screen/visitor/visitor_detail_screen.dart';

class VisitorUmkm extends StatefulWidget {
  const VisitorUmkm({super.key, required this.title});

  final String title;

  @override
  _VisitorUmkmState createState() => _VisitorUmkmState();
}

class _VisitorUmkmState extends State<VisitorUmkm> {
  bool btnPressed1 = false;
  bool btnPressed2 = false;
  bool btnPressed3 = false;
  bool btnPressed4 = false;
  bool btnPressed5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: true,
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column (
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                  decoration: const InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Color(0xff4A4A4A),
                      fontSize: 14,
                    ),
                    suffixIcon: Icon(Icons.search)
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            btnPressed1 = !btnPressed1;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: btnPressed1 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              width: 1
                          ), //<-- SEE
                          backgroundColor: btnPressed1 ? const Color(0xffEEFBFF) : Colors.transparent,
                        ),
                        child: Text('Filter 1',
                          style: TextStyle(
                              color: btnPressed1 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              fontWeight: FontWeight.normal,
                              fontSize: 13
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            btnPressed2 = !btnPressed2;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: btnPressed2 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              width: 1
                          ), //<-- SEE
                          backgroundColor: btnPressed2 ? const Color(0xffEEFBFF) : Colors.transparent,
                        ),
                        child: Text('Filter 2',
                          style: TextStyle(
                              color: btnPressed2 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              fontWeight: FontWeight.normal,
                              fontSize: 13
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            btnPressed3 = !btnPressed3;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: btnPressed3 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              width: 1
                          ), //<-- SEE
                          backgroundColor: btnPressed3 ? const Color(0xffEEFBFF) : Colors.transparent,
                        ),
                        child: Text('Filter 3',
                          style: TextStyle(
                              color: btnPressed3 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              fontWeight: FontWeight.normal,
                              fontSize: 13
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            btnPressed4 = !btnPressed4;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: btnPressed4 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              width: 1
                          ), //<-- SEE
                          backgroundColor: btnPressed4 ? const Color(0xffEEFBFF) : Colors.transparent,
                        ),
                        child: Text('Filter 4',
                          style: TextStyle(
                              color: btnPressed4 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              fontWeight: FontWeight.normal,
                              fontSize: 13
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            btnPressed5 = !btnPressed5;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: btnPressed5 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              width: 1
                          ), //<-- SEE
                          backgroundColor: btnPressed5 ? const Color(0xffEEFBFF) : Colors.transparent,
                        ),
                        child: Text('Filter 5',
                          style: TextStyle(
                              color: btnPressed5 ? const Color(0xff19A7CE) : const Color(0xffA6A6A6),
                              fontWeight: FontWeight.normal,
                              fontSize: 13
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const VisitorDetail(title: 'Detail UMKM'))
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
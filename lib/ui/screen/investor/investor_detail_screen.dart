import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/login/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class InvestorDetail extends StatefulWidget {
  const InvestorDetail({super.key, required this.title});

  final String title;

  @override
  _InvestorDetailState createState() => _InvestorDetailState();
}

class _InvestorDetailState extends State<InvestorDetail> {
  final List<String> genderItems = [
    '100000',
    '250000',
    '500000',
    '1000000'
  ];

  String? selectedValue = '0';

  final _formKey = GlobalKey<FormState>();

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
                                'FOTO $i',
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
                                Text("Rp X.00.000",
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
                    color: const Color(0xffE4F9FF),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 125,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Tentang UMKM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....')
                      ],
                    )
                ),

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
                            Text("X0 Minggu",
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
                            Text("XX%",
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
                            Text("Bulanan",
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
                            Text("Rp. XX.XXX",
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
                            Text("Rp.XXX.XXX",
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
                            Text("XXXXXXXX",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                ElevatedButton(
                  onPressed:  ()  {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19A7CE),
                      fixedSize: const Size(double.maxFinite, 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text(
                    "Lihat Laporan Keuangan",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Pilih nominal pendanaan',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          items: genderItems.map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                                'Rp$item'
                            ),
                          )).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Mohon pilih No. rekening tujuan anda!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            selectedValue = value.toString();
                          },
                          onSaved: (value) {
                            selectedValue = value.toString();
                          },
                          buttonStyleData: const ButtonStyleData(
                            height: 60,
                            padding: EdgeInsets.only(right: 10),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
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
              height: 114,
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
              child: Column (
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Tagihan'),
                        Text('Rp${selectedValue ?? '0'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed:  ()  {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff19A7CE),
                        fixedSize: const Size(double.maxFinite, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text(
                      "Beri Modal Sekarang!",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
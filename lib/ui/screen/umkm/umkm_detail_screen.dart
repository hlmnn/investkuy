import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/screen/umkm/umkm_daftar_investor_screen.dart';
import 'package:investkuy/data/data_state.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/date_formatter.dart';
import '../../../utils/string_format.dart';
import '../../cubit/detail_umkm_cubit.dart';

class UmkmDetail extends StatefulWidget {
  const UmkmDetail({super.key, required this.title, required this.id});

  final String title;
  final int id;

  @override
  _UmkmDetailState createState() => _UmkmDetailState();
}

class _UmkmDetailState extends State<UmkmDetail> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailUmkmCubit>(context)
        .getDetailUmkm(widget.id.toString());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
          automaticallyImplyLeading: true,
        ),
        body: BlocBuilder<DetailUmkmCubit, DataState>(
          builder: (context, state) {
            int id = 0;
            String nama = "";
            String alamat = "";
            String imgUrl = "";
            String sektor = "";
            String imgUmkmUrl1 = "";
            String imgUmkmUrl2 = "";
            String imgUmkmUrl3 = "";
            int plafond = 0;
            double bagiHasilCurrency = 0;
            int bagiHasilPercent = 0;
            int tenor = 0;
            String deskripsi = "";
            int jumlahAngsuran = 0;
            String jenisAngsuran = "";
            String penghasilan = "";
            String pekerjaan = "";
            int jumlahPendanaan = 0;
            String tanggalMulai = "";
            String tanggalBerakhir = "";
            double progressValue = 0.0;
            Widget img = const Icon(
              Icons.account_circle_rounded,
              size: 70,
            );

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SuccessState) {
              final data = state.data as DetailUmkmModel;
              id = data.id;
              nama = data.detailPemilik.name;
              alamat = data.detailPemilik.alamat;
              imgUrl = data.detailPemilik.img;
              sektor = data.sektor;
              imgUmkmUrl1 = data.fotoUmkm.imgUrl1;
              imgUmkmUrl2 = data.fotoUmkm.imgUrl2;
              imgUmkmUrl3 = data.fotoUmkm.imgUrl3;
              plafond = data.plafond;
              tenor = data.tenor;
              bagiHasilPercent = data.bagiHasil;
              bagiHasilCurrency =
                  (plafond / tenor) * (bagiHasilPercent / 100) * tenor;
              deskripsi = data.deskripsi;
              jenisAngsuran = data.jenisAngsuran;
              jumlahAngsuran = data.jumlahAngsuran;
              penghasilan = data.penghasilan;
              pekerjaan = data.pekerjaan;
              jumlahPendanaan = data.jumlahPendanaan;
              tanggalMulai = data.tanggalMulai;
              tanggalBerakhir = data.tanggalBerakhir;
              progressValue = jumlahPendanaan / plafond;

              if (data.detailPemilik.img != "") {
                img = CircleAvatar(
                  backgroundImage: NetworkImage(imgUrl),
                  radius: 35,
                );
              }
            }

            return SingleChildScrollView(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: img,
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          nama,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          sektor != ""
                                              ? StringFormat.capitalizeAllWord(
                                                  sektor)
                                              : sektor,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            alamat != ""
                                                ? StringFormat
                                                    .capitalizeAllWord(alamat)
                                                : alamat,
                                            style: const TextStyle(
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
                          height: 200.0,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          autoPlay: true,
                          initialPage: 0,
                        ),
                        items: [imgUmkmUrl1, imgUmkmUrl2, imgUmkmUrl3]
                            .map((itemImgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                    color: Color(0xffE4F9FF)),
                                child: Image.network(
                                  itemImgUrl,
                                  fit: BoxFit.cover,
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
                                  children: [
                                    const Text("Plafond"),
                                    Text(
                                      plafond != 0
                                          ? CurrencyFormat.convertToIdr(
                                              plafond, 0)
                                          : "-",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text("Bagi Hasil"),
                                    Text(
                                      bagiHasilCurrency != 0
                                          ? CurrencyFormat.convertToIdr(
                                              bagiHasilCurrency, 0)
                                          : "-",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text("Tenor"),
                                    Text(
                                      "$tenor Minggu",
                                      style: const TextStyle(
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
                        height: 125,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tentang UMKM',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(deskripsi,
                                maxLines: 5, overflow: TextOverflow.ellipsis)
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
                              children: [
                                const Text("Tenor Pendanaan"),
                                Text(
                                  "$tenor Minggu",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Imbal Hasil (%)"),
                                Text(
                                  "$bagiHasilPercent%",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Jenis Angsuran"),
                                Text(
                                  jenisAngsuran,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Jumlah Angsuran"),
                                Text(
                                  jumlahAngsuran != 0
                                      ? CurrencyFormat.convertToIdr(
                                          jumlahAngsuran, 0)
                                      : "0",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Penghasilan Perbulan"),
                                Text(
                                  penghasilan,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Pekerjaan"),
                                Text(
                                  pekerjaan,
                                  style: const TextStyle(
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
                            children: [
                              const Text("Dana Terkumpul"),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                jumlahPendanaan != 0
                                    ? CurrencyFormat.convertToIdr(
                                        jumlahPendanaan, 0)
                                    : "0",
                                style: const TextStyle(
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
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  minHeight: 20,
                                  color: const Color(0xff19A7CE),
                                  backgroundColor: const Color(0xff90E7FF),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text("Tanggal"),
                                  ),
                                  Text(
                                    ": ${DateFormatter.convertToDate(tanggalMulai)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(" s/d "),
                                  Text(
                                    DateFormatter.convertToDate(
                                        tanggalBerakhir),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    /* ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UmkmLaporanKeuangan(
                                    title: "Tambah Laporan Keuangan",
                                    id: id)));
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
                    const SizedBox(height: 5), */
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UmkmDaftarInvestor(
                                    title: "Daftar Investor",
                                    id: id)));
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
            );
          },
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff19A7CE),
                        fixedSize: const Size(double.maxFinite, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Batalkan Pengajuan",
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

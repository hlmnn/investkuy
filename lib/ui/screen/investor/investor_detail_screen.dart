import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/cubit/detail_umkm_cubit.dart';
import 'package:investkuy/ui/screen/investor/investor_confirm_cancel_screen.dart';
import 'package:investkuy/ui/screen/investor/investor_confirm_pendanaan_screen.dart';
import 'package:investkuy/ui/screen/investor/investor_confirm_withdraw_screen.dart';
import 'package:investkuy/ui/screen/login/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:investkuy/ui/screen/visitor/visitor_laporan_screen.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/string_format.dart';

class InvestorDetail extends StatefulWidget {
  const InvestorDetail(
      {super.key, required this.title, required this.id, this.pendanaanId});

  final String title;
  final String id;
  final int? pendanaanId;

  @override
  _InvestorDetailState createState() => _InvestorDetailState();
}

class _InvestorDetailState extends State<InvestorDetail> {
  final List<String> nominal = ['100000', '250000', '500000', '1000000'];

  String selectedValue = '0';
  int idPendanaan = 0;

  final _formKey = GlobalKey<FormState>();

  Future refresh() async {
    selectedValue = '0';
    BlocProvider.of<DetailUmkmCubit>(context).getDetailUmkm(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailUmkmCubit>(context).getDetailUmkm(widget.id);
    if (widget.pendanaanId != null) {
      setState(() {
        idPendanaan = widget.pendanaanId!;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<DetailUmkmCubit, DataState>(
        builder: (context, state) {
          String sektor = "";
          int plafond = 0;
          String bagiHasil = "";
          String tenor = "";
          String jumlahPendanaan = "";
          String tanggalMulai = "";
          String tanggalBerakhir = "";
          String nama = "";
          String alamat = "";
          String imgUrl = "";
          bool isFunded = false;
          String pekerjaan = "";
          String akad = "";
          String angsuranDibayar = "";
          String deskripsi = "";
          String imgUmkmUrl1 = "";
          String imgUmkmUrl2 = "";
          String imgUmkmUrl3 = "";
          bool isWithdraw = false;
          String jenisAngsuran = "";
          String penghasilan = "";
          String status = "";
          String tanggalMulaiBayar = "";
          int jumlahAngsuran = 0;
          bool test = false;
          Widget img = const Icon(
            Icons.account_circle_rounded,
            size: 70,
          );

          if (state is LoadingState) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SuccessState) {
            final data = state.data['data'] as DetailUmkmModel;
            sektor = data.sektor;
            plafond = data.plafond;
            bagiHasil = data.bagiHasil.toString();
            tenor = data.tenor.toString();
            jumlahPendanaan = data.jumlahPendanaan.toString();
            tanggalMulai = data.tanggalMulai;
            tanggalBerakhir = data.tanggalBerakhir;
            nama = data.detailPemilik.name;
            alamat = data.detailPemilik.alamat;
            imgUrl = data.detailPemilik.img;
            isFunded = data.isFunded;
            pekerjaan = data.pekerjaan;
            akad = data.akad;
            angsuranDibayar = data.angsuranDibayar.toString();
            deskripsi = data.deskripsi;
            imgUmkmUrl1 = data.fotoUmkm.imgUrl1;
            imgUmkmUrl2 = data.fotoUmkm.imgUrl2;
            imgUmkmUrl3 = data.fotoUmkm.imgUrl3;
            isWithdraw = data.isWithdraw;
            jenisAngsuran = data.jenisAngsuran;
            penghasilan = data.penghasilan;
            status = data.status;
            tanggalMulaiBayar = data.tanggalMulaiBayar;
            jumlahAngsuran = data.jumlahAngsuran;

            if (data.detailPemilik.img != "") {
              img = CircleAvatar(
                backgroundImage: NetworkImage(imgUrl),
                radius: 35,
              );
            }
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      nama,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
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
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      alamat != ""
                                          ? StringFormat.capitalizeAllWord(
                                              alamat)
                                          : alamat,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          autoPlay: true,
                          initialPage: 0,
                        ),
                        items: [imgUmkmUrl1, imgUmkmUrl2, imgUmkmUrl3]
                            .map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xffE4F9FF),
                                ),
                                child: Image.network(
                                  imgUrl,
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
                                        : "",
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
                                    "$bagiHasil%",
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
                      ),
                    ),
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
                          Text(
                            deskripsi,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
                                "$bagiHasil%",
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
                                jenisAngsuran != ""
                                    ? StringFormat.capitalizeAllWord(
                                        jenisAngsuran)
                                    : "",
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
                                pekerjaan != ""
                                    ? StringFormat.capitalizeAllWord(pekerjaan)
                                    : "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VisitorLaporanScreen(
                                id: widget.id,
                                title: "Daftar Laporan Keuangan"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff19A7CE),
                          fixedSize: const Size(double.maxFinite, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Lihat Laporan Keuangan",
                        style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    if (!isFunded && status == "In Progress")
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Form(
                          key: _formKey,
                          child: DropdownButtonFormField2(
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
                            value: selectedValue != "0" ? selectedValue : null,
                            items: nominal
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      CurrencyFormat.convertToIdr(
                                        int.parse(item),
                                        0,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Mohon pilih nominal pendanaan';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
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
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: BlocBuilder<DetailUmkmCubit, DataState>(
          builder: (context, state) {
            bool isFunded = false;
            bool isWithdraw = false;
            bool isVerified = false;
            String status = "";
            String name = "";
            int id = 0;
            if (state is SuccessState) {
              isFunded = state.data['data'].isFunded;
              isWithdraw = state.data['data'].isWithdraw;
              isVerified = state.data['isVerified'];
              status = state.data['data'].status;
              name = state.data['data'].detailPemilik.name;
              id = state.data['data'].id;
            }
            Widget data = Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Tagihan'),
                      Text(
                        selectedValue != '0'
                            ? CurrencyFormat.convertToIdr(
                                int.parse(selectedValue), 0)
                            : "Rp 0",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InvestorConfirmPendanaanScreen(
                            nominal: int.parse(selectedValue),
                            name: name,
                            id: id,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff19A7CE),
                    fixedSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Beri Modal Sekarang!",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            );
            if (isFunded) {
              data = ElevatedButton(
                onPressed: status == "In Progress" ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvestorConfirmCancelScreen(
                        name: name,
                        id: id,
                      ),
                    ),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff19A7CE),
                  fixedSize: const Size(double.maxFinite, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBackgroundColor: const Color(0xff5b7882),
                ),
                child: const Text(
                  "Batalkan Investasi",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            }
            if (status != "In Progress" && status != "Payment Period") {
              data = ElevatedButton(
                onPressed: isWithdraw
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InvestorConfirmWithdrawScreen(
                              pendanaanId: idPendanaan,
                              id: id,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff19A7CE),
                    fixedSize: const Size(double.maxFinite, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBackgroundColor: const Color(0xff5b7882)),
                child: const Text(
                  "Withdraw Profit",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            }
            if (!isVerified) {
              data = const Center(
                child: Text(
                  "Akun anda belum terverifikasi, silahkan melakukan verifikasi akun terlebih dahulu.",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.all(20),
              height: isFunded || isWithdraw || !isWithdraw ? 90 : 114,
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
              child: data,
            );
          },
        ),
      ),
    );
  }
}

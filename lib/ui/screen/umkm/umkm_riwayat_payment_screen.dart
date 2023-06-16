import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/cubit/umkm_riwayat_cubit.dart';
import 'package:investkuy/ui/screen/umkm/umkm_detail_cicilan_screen.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/date_formatter.dart';

class RiwayatPayment extends StatefulWidget {
  const RiwayatPayment({super.key, required this.title});

  final String title;

  @override
  _RiwayatPaymentState createState() => _RiwayatPaymentState();
}

class _RiwayatPaymentState extends State<RiwayatPayment>
    with AutomaticKeepAliveClientMixin {
  Future refresh() async {
    BlocProvider.of<UmkmRiwayatPaymentCubit>(context).getAllRiwayatPayment();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UmkmRiwayatPaymentCubit>(context).getAllRiwayatPayment();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<UmkmRiwayatPaymentCubit, DataState>(
          builder: (context, state) {
        List<RiwayatPaymentModel> listRiwayatPayment = [];

        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SuccessState) {
          if (state.data is List<RiwayatPaymentModel>) {
            listRiwayatPayment = state.data;
          }
        }

        if (listRiwayatPayment.isEmpty) {
          return RefreshIndicator(
              onRefresh: refresh,
              child: ListView(
                  children : [Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50, bottom: 5, left: 20, right: 20),
                        child: Column(
                          children: [
                            const Text(
                                "Anda tidak memiliki riwayat payment saat ini!",
                                style: TextStyle(fontSize: 15)),
                            Image.network(
                              'https://thumb1.shutterstock.com/mosaic_250/255170779/2172684639/stock-vector-document-file-not-found-search-no-result-concept-illustration-flat-design-vector-eps-modern-2172684639.jpg',
                              fit: BoxFit.fill,
                            ),
                          ],
                        )
                      )
                    )
                  ]
                )
              );
        }

        return RefreshIndicator(
          onRefresh: refresh,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            child: ListView.builder(
              itemCount: listRiwayatPayment.length,
              itemBuilder: (BuildContext context, int index) {
                final itemRiwayatPayment = listRiwayatPayment[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UmkmDetailCicilan(
                                title: 'Detail UMKM',
                                id: itemRiwayatPayment.id)));
                  },
                  child: Card(
                    color: const Color(0xffE4F9FF),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          const Text("Plafond"),
                                          Text(
                                            CurrencyFormat.convertToIdr(
                                                itemRiwayatPayment.plafond, 0),
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
                                            "${itemRiwayatPayment.bagiHasil}%",
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
                                            "${itemRiwayatPayment.tenor} Minggu",
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
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Text("Dana Terkumpul"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(CurrencyFormat.convertToIdr(
                                        itemRiwayatPayment.jumlahPendanaan, 0)),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text("Jatuh Tempo"),
                                    ),
                                    Text(
                                      DateFormatter.convertToDate(
                                          itemRiwayatPayment.jatuhTempo),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text("Angsuran"),
                                    ),
                                    Text(
                                      CurrencyFormat.convertToIdr(
                                          itemRiwayatPayment.jumlahAngsuran, 0),
                                      style: const TextStyle(
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
                                  children: [
                                    Text(
                                      itemRiwayatPayment.status,
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
            ),
          ),
        );
      }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

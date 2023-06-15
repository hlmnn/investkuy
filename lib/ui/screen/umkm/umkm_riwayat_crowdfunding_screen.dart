import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:investkuy/ui/cubit/umkm_riwayat_cubit.dart';
import 'package:investkuy/ui/screen/umkm/umkm_detail_screen.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:investkuy/data/data_state.dart';

import '../../../data/model/umkm_model.dart';

class RiwayatCrowdfunding extends StatefulWidget {
  const RiwayatCrowdfunding({super.key, required this.title});

  final String title;

  @override
  _RiwayatCrowdfundingState createState() => _RiwayatCrowdfundingState();
}

class _RiwayatCrowdfundingState extends State<RiwayatCrowdfunding> {
  Future refresh() async {
    BlocProvider.of<UmkmRiwayatCubit>(context).getAllRiwayatCrowdfunding();
  }

   
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<UmkmRiwayatCubit>(context).getAllRiwayatCrowdfunding();
    return Scaffold(
        backgroundColor: Colors.white,
        body:
            BlocBuilder<UmkmRiwayatCubit, DataState>(builder: (context, state) {

          List<RiwayatCrowdfundingModel> listRiwayatCrowdfunding = [];

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            if (state.data is List<RiwayatCrowdfundingModel>) {
              listRiwayatCrowdfunding = state.data;
            }
          }

          return RefreshIndicator(
            onRefresh: refresh,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: ListView.builder(
                itemCount: listRiwayatCrowdfunding.length,
                itemBuilder: (context, index) {
                  final itemRiwayatCF = listRiwayatCrowdfunding[index];
                  double jmlBagiHasil =
                      (itemRiwayatCF.plafond / itemRiwayatCF.tenor) *
                          (itemRiwayatCF.bagiHasil / 100) *
                          itemRiwayatCF.tenor;
                  DateTime dateStart = DateTime.parse(itemRiwayatCF.tanggalMulai);
                  String formattedDateStart =
                      DateFormat('dd/MM/yyyy').format(dateStart);
                  DateTime dateFinish =
                      DateTime.parse(itemRiwayatCF.tanggalBerakhir);
                  String formattedDateFinish =
                      DateFormat('dd/MM/yyyy').format(dateFinish);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UmkmDetail(title: 'Detail UMKM')));
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
                                                  itemRiwayatCF.plafond, 0),
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
                                              CurrencyFormat.convertToIdr(
                                                  jmlBagiHasil, 0),
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
                                              "${itemRiwayatCF.tenor} Minggu",
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
                                          itemRiwayatCF.jumlahPendanaan, 0)),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        child: LinearProgressIndicator(
                                          value: itemRiwayatCF.jumlahPendanaan /
                                              itemRiwayatCF.plafond,
                                          minHeight: 20,
                                          color: const Color(0xff19A7CE),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text("Tanggal"),
                                      ),
                                      Text(
                                        ": $formattedDateStart",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(" s/d "),
                                      Text(
                                        formattedDateFinish,
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
                                        itemRiwayatCF.status,
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
          ));
        }));
  }
}

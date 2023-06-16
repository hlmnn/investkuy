import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/pendanaan_model.dart';
import 'package:investkuy/ui/cubit/investor_riwayat_cubit.dart';
import 'package:investkuy/ui/screen/investor/investor_detail_screen.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/date_formatter.dart';
import 'package:investkuy/utils/string_format.dart';

class RiwayatCompleted extends StatefulWidget {
  const RiwayatCompleted({super.key, required this.title});

  final String title;

  @override
  _RiwayatCompletedState createState() => _RiwayatCompletedState();
}

class _RiwayatCompletedState extends State<RiwayatCompleted> {
  Future refresh() async {
    BlocProvider.of<InvestorRiwayatCompletedCubit>(context)
        .getAllCompletedPendanaan();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<InvestorRiwayatCompletedCubit>(context)
        .getAllCompletedPendanaan();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<InvestorRiwayatCompletedCubit, DataState>(
        builder: (context, state) {
          List<CompletedPendanaanModel> data = [];
          if (state is LoadingState) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SuccessState) {
            data = state.data;
          }

          return RefreshIndicator(
            onRefresh: refresh,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: data.isEmpty
                  ? const Center(
                      child:
                          Text("Tidak ada pendanaan yang sedang berlangsung"),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = data[index];
                        Widget img = const Icon(
                          Icons.account_circle_rounded,
                          size: 70,
                        );
                        if (item.pengajuan.pemilik.imgUrl != "") {
                          img = CircleAvatar(
                            backgroundImage:
                                NetworkImage(item.pengajuan.pemilik.imgUrl),
                            radius: 35,
                          );
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InvestorDetail(
                                  title: 'Detail UMKM',
                                  id: item.pengajuan.id.toString(),
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
                                    margin: const EdgeInsets.only(bottom: 10),
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
                                            padding: const EdgeInsets.only(
                                              left: 5,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 6,
                                                  ),
                                                  child: Text(
                                                    item.pengajuan.pemilik.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 6,
                                                  ),
                                                  child: Text(
                                                    StringFormat
                                                        .capitalizeAllWord(item
                                                            .pengajuan.sektor),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 6,
                                                  ),
                                                  child: Text(
                                                    StringFormat
                                                        .capitalizeAllWord(item
                                                            .pengajuan
                                                            .pemilik
                                                            .alamat),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            const Text("Plafond"),
                                            Text(
                                              CurrencyFormat.convertToIdr(
                                                  item.pengajuan.plafond, 0),
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
                                              "${item.pengajuan.bagiHasil}%",
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
                                              "${item.pengajuan.tenor} Minggu",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Text("Selesai"),
                                            ),
                                            Text(
                                              ": ${DateFormatter.convertToDate(item.tanggalSelesai)}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Text("Status"),
                                            ),
                                            Text(
                                              ": ${StringFormat.capitalizeAllWord(item.status)}",
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
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text("Jumlah Pendanaan"),
                                        ),
                                        Text(
                                          ": ${CurrencyFormat.convertToIdr(item.nominal, 0)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text("Keuntungan"),
                                        ),
                                        Text(
                                          ": ${CurrencyFormat.convertToIdr(item.profit, 0)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
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
        },
      ),
    );
  }
}

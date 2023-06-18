import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/cubit/list_investor_cubit.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/string_format.dart';

class UmkmDaftarInvestor extends StatefulWidget {
  const UmkmDaftarInvestor({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  _UmkmDaftarInvestorState createState() => _UmkmDaftarInvestorState();
}

class _UmkmDaftarInvestorState extends State<UmkmDaftarInvestor> {
  Future refresh() async {
    BlocProvider.of<ListInvestorCubit>(context).getAllInvestor(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListInvestorCubit>(context).getAllInvestor(widget.id);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
        ),
        body: BlocBuilder<ListInvestorCubit, DataState>(
          builder: (context, state) {
            List<DaftarInvestorModel> listInvestor = [];
            String name = "";
            String imgUrl = "";
            int nominal = 0;

            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessState) {
              listInvestor = state.data;
            }

            if (listInvestor.isEmpty) {
              return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView(children: [
                    Center(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 50, bottom: 5, left: 20, right: 20),
                            child: Column(
                              children: [
                                const Text(
                                    "Pengajuan tidak memiliki investor/pendana!",
                                    style: TextStyle(fontSize: 15)),
                                Image.asset(
                                  'assets/images/empty.png',
                                  fit: BoxFit.fill,
                                ),
                              ],
                            )))
                  ]));
            }

            return RefreshIndicator(
                onRefresh: refresh,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: listInvestor.length,
                          itemBuilder: (BuildContext context, int index) {
                            final itemInvestor = listInvestor[index];
                            name = itemInvestor.investorDetails.name;
                            imgUrl = itemInvestor.investorDetails.imgUrl;
                            nominal = itemInvestor.nominal;

                            Widget img = const Icon(
                              Icons.account_circle_rounded,
                              size: 70,
                            );

                            if (itemInvestor.investorDetails.imgUrl != "") {
                              img = CircleAvatar(
                                backgroundImage: NetworkImage(imgUrl),
                                radius: 35,
                              );
                            }

                            return InkWell(
                              onTap: () {},
                              child: Card(
                                color: const Color(0xffE4F9FF),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
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
                                                  left: 5),
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
                                                            bottom: 8),
                                                    child: Text(
                                                      name != ""
                                                          ? StringFormat
                                                              .capitalizeAllWord(
                                                                  name)
                                                          : name,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 6),
                                                    child: Text(
                                                      "Dana yang diberi",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 6),
                                                    child: Text(
                                                      nominal != 0
                                                          ? CurrencyFormat
                                                              .convertToIdr(
                                                                  nominal, 0)
                                                          : "-",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
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
                ));
          },
        ));
  }
}

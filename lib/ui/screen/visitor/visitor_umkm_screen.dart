import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/cubit/list_umkm_cubit.dart';
import 'package:investkuy/ui/screen/login/login_screen.dart';
import 'package:investkuy/ui/screen/visitor/visitor_detail_screen.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/string_format.dart';

class VisitorUmkm extends StatefulWidget {
  const VisitorUmkm({super.key, required this.title});

  final String title;

  @override
  _VisitorUmkmState createState() => _VisitorUmkmState();
}

class _VisitorUmkmState extends State<VisitorUmkm> {
  String sort = "";
  String order = "";
  String tenor = "";
  String sektor = "";
  String plafond = "";

  final scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      sort = "";
      order = "";
      tenor = "";
      sektor = "";
      plafond = "";
    });
    BlocProvider.of<ListUmkmCubit>(context)
        .getAllPengajuan(true, sort, order, tenor, sektor, plafond);
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<ListUmkmCubit>(context)
              .getAllPengajuan(false, sort, order, tenor, sektor, plafond);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    BlocProvider.of<ListUmkmCubit>(context)
        .getAllPengajuan(false, sort, order, tenor, sektor, plafond);

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
        padding: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocBuilder<ListUmkmCubit, DataState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 200,
                              height: 48,
                              child: DropdownButtonFormField2(
                                isDense: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Urutkan',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                value: order,
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text("Urutkan"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ASC",
                                    child: Text("Terlama"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "DESC",
                                    child: Text("Terbaru"),
                                  ),
                                ],
                                buttonStyleData: const ButtonStyleData(
                                  height: 48,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 48,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  sort = "1";
                                  order = value.toString();
                                  context.read<ListUmkmCubit>().getAllPengajuan(
                                      true,
                                      sort,
                                      order,
                                      tenor,
                                      sektor,
                                      plafond);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 200,
                              height: 48,
                              child: DropdownButtonFormField2(
                                isDense: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Tenor',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                value: tenor,
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text("Tenor"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "25",
                                    child: Text("25 Minggu"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "50",
                                    child: Text("50 Minggu"),
                                  ),
                                ],
                                buttonStyleData: const ButtonStyleData(
                                  height: 48,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 48,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  tenor = value.toString();
                                  context.read<ListUmkmCubit>().getAllPengajuan(
                                      true,
                                      sort,
                                      order,
                                      tenor,
                                      sektor,
                                      plafond);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 200,
                              height: 48,
                              child: DropdownButtonFormField2(
                                isDense: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Sektor',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                value: sektor,
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text("Sektor"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "perdagangan",
                                    child: Text("Perdagangan"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "jasa",
                                    child: Text("Jasa"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "pertanian",
                                    child: Text("Pertanian"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peternakan",
                                    child: Text("Peternakan"),
                                  ),
                                ],
                                buttonStyleData: const ButtonStyleData(
                                  height: 48,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 48,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  sektor = value.toString();
                                  context.read<ListUmkmCubit>().getAllPengajuan(
                                      true,
                                      sort,
                                      order,
                                      tenor,
                                      sektor,
                                      plafond);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 200,
                              height: 48,
                              child: DropdownButtonFormField2(
                                isDense: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Urutkan',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                value: plafond,
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text("Plafond"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "1000000",
                                    child: Text("Rp 1.000.000"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "2000000",
                                    child: Text("Rp 2.000.000"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "3000000",
                                    child: Text("Rp 3.000.000"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "4000000",
                                    child: Text("Rp 4.000.000"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "5000000",
                                    child: Text("Rp 5.000.000"),
                                  ),
                                ],
                                buttonStyleData: const ButtonStyleData(
                                  height: 48,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 48,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  plafond = value.toString();
                                  context.read<ListUmkmCubit>().getAllPengajuan(
                                        true,
                                        sort,
                                        order,
                                        tenor,
                                        sektor,
                                        plafond,
                                      );
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff19A7CE),
                            ),
                            child: OutlinedButton(
                              onPressed: () {
                                sort = "";
                                order = "";
                                tenor = "";
                                sektor = "";
                                plafond = "";
                                context.read<ListUmkmCubit>().getAllPengajuan(
                                    true, sort, order, tenor, sektor, plafond);
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide.none),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ListUmkmCubit, DataState>(
                builder: (context, state) {
                  if (state is LoadingPaginationState && state.isFirstFetch) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<UmkmModel> items = [];
                  bool isLoading = false;

                  if (state is LoadingPaginationState) {
                    items = state.oldData;
                    isLoading = true;
                  } else if (state is SuccessState) {
                    items = state.data;
                  }

                  if (items.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada data."),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: items.length + (isLoading ? 1 : 0),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < items.length) {
                          final item = items[index];
                          Widget img = const Icon(
                            Icons.account_circle_rounded,
                            size: 70,
                          );
                          if (item.detailPemilik.img != "") {
                            img = CircleAvatar(
                              backgroundImage:
                                  NetworkImage(item.detailPemilik.img),
                              radius: 35,
                            );
                          }

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VisitorDetail(title: 'Detail UMKM', id: item.id.toString(),),
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
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
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
                                                        item.detailPemilik.name,
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
                                                            .capitalizeAllWord(
                                                                item.sektor),
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
                                                            .capitalizeAllWord(
                                                          item.detailPemilik
                                                              .alamat,
                                                        ),
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
                                        )),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                        item.plafond, 2),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text("Bagi Hasil"),
                                                  Text(
                                                    "${item.bagiHasil.toString()}%",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text("Tenor"),
                                                  Text(
                                                    "X${item.tenor.toString()} Minggu",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
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
                        } else {
                          Timer(const Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          });

                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

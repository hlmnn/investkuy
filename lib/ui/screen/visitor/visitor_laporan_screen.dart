import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/cubit/list_laporan_cubit.dart';
import 'package:investkuy/ui/screen/visitor/visitor_pdf_screen.dart';

class VisitorLaporanScreen extends StatefulWidget {
  const VisitorLaporanScreen(
      {super.key, required this.id, required this.title});

  final String id;
  final String title;

  @override
  State<VisitorLaporanScreen> createState() => _VisitorLaporanScreenState();
}

class _VisitorLaporanScreenState extends State<VisitorLaporanScreen> {
  Future refresh() async {
    BlocProvider.of<ListLaporanCubit>(context)
        .getAllLaporan(int.parse(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListLaporanCubit>(context)
        .getAllLaporan(int.parse(widget.id));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<ListLaporanCubit, DataState>(
        builder: (context, state) {
          List<LaporanModel> items = [];

          if (state is LoadingState) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SuccessState) {
            if (state.data is List<LaporanModel>) {
              items = state.data;
            }
          }

          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5,
              bottom: 5,
            ),
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VisitorPdfScreen(url: item.laporanUrl),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xffE4F9FF),
                        ),
                        child: Text(
                          "Laporan ke-${index + 1}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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

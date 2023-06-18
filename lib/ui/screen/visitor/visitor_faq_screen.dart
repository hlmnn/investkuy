import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/faq_model.dart';
import 'package:investkuy/ui/cubit/faq_cubit.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key, required this.title});

  final String title;

  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faqs> {
  Future refresh() async {
    BlocProvider.of<FaqCubit>(context).getFaq();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FaqCubit>(context).getFaq();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<FaqCubit, DataState>(
        builder: (context, state) {
          List<FaqModel> listFaq = [];
          if (state is LoadingState) {
            // Loading State
            return const CircularProgressIndicator();
          } else if (state is SuccessState) {
            // Success State
            listFaq = state.data;
          }

          if (listFaq.isEmpty) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: ListView(children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50, bottom: 5, left: 20, right: 20),
                    child: Column(
                      children: [
                        const Text("Tidak ada daftar pengajuan saat ini!",
                            style: TextStyle(fontSize: 15)),
                        Image.asset(
                          'assets/images/empty.png',
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 5,
              ),
              child: ListView.builder(
                itemCount: listFaq.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xffE4F9FF),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listFaq[index].question,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(listFaq[index].answer),
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/faq_model.dart';
import 'package:investkuy/main.dart';
import 'package:investkuy/ui/cubit/faq_cubit.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key, required this.title});

  final String title;

  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faqs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
        ),
        body: BlocBuilder<FaqCubit, DataState>(
          builder: (context, state) {
            List<FaqModel> listFaq = [];
            if (state is InitialState) { // Initial State
              context.read<FaqCubit>().getFaq();
            } else if (state is LoadingState) { // Loading State
              return const CircularProgressIndicator();
            } else if (state is SuccessState) { // Success State
              listFaq = state.data;
            }
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                            Text(listFaq[index].answer)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        )
    );
  }
}
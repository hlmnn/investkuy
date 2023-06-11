import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:investkuy/ui/cubit/details_article_cubit.dart';
import 'package:investkuy/data/model/article_model.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailArticles extends StatefulWidget {
  const DetailArticles({super.key, required this.id, required this.title});

  final String title;
  final int id;

  @override
  _DetailArticleState createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
        ),
        body: BlocBuilder<DetailsArticleCubit, DataState>(
          builder: (context, state) {
            String title = "";
            String tglTerbit = "";
            String konten = "";
            String imgUrl = "";
            String adminName = "";
            String formattedDate = "";
            if (state is InitialState) {
              context.read<DetailsArticleCubit>().getDetailsArticle(widget.id);
            } else if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessState) {
              if (state.data is ArticleModel) {
                title = state.data.title;
                tglTerbit = state.data.tglTerbit;
                DateTime date = DateTime.parse(tglTerbit);
                formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(date);
                konten = state.data.konten;
                imgUrl = state.data.imgUrl;
                log(imgUrl);
                adminName = state.data.adminName;
              }
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/plcholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(adminName),
                                Text(formattedDate),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(konten),
                          const SizedBox(height: 8.0),
                        ],
                      )),
                ],
              ),
            );
          },
        ));
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/ui/cubit/article_cubit.dart';
import 'package:investkuy/data/model/article_model.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/screen/visitor/visitor_detailArticles_screen.dart';

class Articles extends StatefulWidget {
  const Articles({super.key, required this.title});

  final String title;

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<ArticleCubit, DataState>(
        builder: (context, state) {
          List<ArticleModel> listArticle = [];

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            if (state.data is List<ArticleModel>) {
              listArticle = state.data;
            }
          }

          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: ListView.builder(
              itemCount: listArticle.length,
              itemBuilder: (context, index) {
                final article = listArticle[index];
                DateTime date = DateTime.parse(article.tglTerbit);
                DateTime now = DateTime.now();
                log(now.toString());
                log(date.toString());
                Duration dateDiff = now.difference(date);
                String formattedDate = "${dateDiff.inDays} days ago";

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailArticles(
                                id: article.id, title: 'Detail Artikel')));
                  },
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
                            article.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            article.konten,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(formattedDate),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Article {
  final String title;
  final String content;
  final String date;
  final String image;
  final String author;

  Article({
    required this.title,
    required this.content,
    required this.date,
    required this.image,
    required this.author,
  });
}

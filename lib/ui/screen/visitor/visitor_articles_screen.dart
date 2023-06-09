import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/visitor/visitor_detailArticles_screen.dart';

class Articles extends StatefulWidget {
  const Articles({super.key, required this.title});

  final String title;

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Articles> {
  final List<Article> articles = [
    Article(
        date: 'x days ago',
        title: 'Judul',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
        image: 'assets/images/logo.png',
        author: 'Penulis'),
    Article(
        date: 'x days ago',
        title: 'Judul',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
        image: 'assets/images/logo.png',
        author: 'Penulis'),
    Article(
        date: 'x days ago',
        title: 'Judul',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
        image: 'assets/images/logo.png',
        author: 'Penulis'),
    Article(
        date: 'x days ago',
        title: 'Judul',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
        image: 'assets/images/logo.png',
        author: 'Penulis'),
    Article(
        date: 'x days ago',
        title: 'Judul',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
        image: 'assets/images/logo.png',
        author: 'Penulis'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
          child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DetailArticles(title: 'Detail Artikel')));
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
                        SizedBox(height: 8.0),
                        Text(article.content),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(article.date),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
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

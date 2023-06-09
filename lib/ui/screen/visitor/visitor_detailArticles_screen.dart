import 'package:flutter/material.dart';

class DetailArticles extends StatefulWidget {
  const DetailArticles({super.key, required this.title});

  final String title;

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Judul',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Penulis'),
                          Text('DD/MM/YYYY'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
                    ),
                    const SizedBox(height: 8.0),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String content;
  final String date;

  Article({required this.title, required this.content, required this.date});
}

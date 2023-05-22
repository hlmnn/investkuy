import 'package:flutter/material.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key, required this.title});

  final String title;

  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faqs> {
  final List<Faq> faq = [
    Faq(
      question: 'Q: LOREM IPSUM',
      answer:
          'A: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
    ),
    Faq(
      question: 'Q: LOREM IPSUM',
      answer:
          'A: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
    ),
    Faq(
      question: 'Q: LOREM IPSUM',
      answer:
          'A: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
    ),
    Faq(
      question: 'Q: LOREM IPSUM',
      answer:
          'A: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
    ),
    Faq(
      question: 'Q: LOREM IPSUM',
      answer:
          'A: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit elit a cursus varius. Nullam quam augue, auctor ac purus at, lacinia mollis dolor. Praesent placerat suscipit hendrerit. Nullam pellentesque purus a metus viverra facilisis....',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
          child: ListView.builder(
            itemCount: faq.length,
            itemBuilder: (context, index) {
              final Faq = faq[index];
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xffE4F9FF),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Faq.question,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(Faq.answer),
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

class Faq {
  final String question;
  final String answer;

  Faq({required this.question, required this.answer});
}

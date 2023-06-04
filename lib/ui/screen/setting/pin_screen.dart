import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pin extends StatefulWidget {
  const Pin({super.key, required this.title});

  final String title;

  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  final _formKey = GlobalKey<FormState>();

  bool isObsecurePass1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff146C94)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 15, top: 20, bottom: 20),
                        hintText: 'PIN Lama',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      maxLength: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff146C94)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 15, top: 20, bottom: 20),
                        hintText: 'PIN Baru',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      maxLength: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff146C94)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 15, top: 20, bottom: 20),
                        hintText: 'Masukan Kembali PIN Baru',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      maxLength: 6,
                    ),
                    TextFormField(
                      obscureText: isObsecurePass1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff146C94)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 15, top: 20, bottom: 20),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(isObsecurePass1
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isObsecurePass1 = !isObsecurePass1;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              padding: const EdgeInsets.all(20),
              height: 90,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column (
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff19A7CE),
                        fixedSize: const Size(double.maxFinite, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Ubah PIN",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
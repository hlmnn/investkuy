import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key, required this.title});

  final String title;

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  var error = 'Mohon pilih No. rekening tujuan anda!';
  final List<String> bankItems = [
    'Bank BRI',
    'Bank BCA',
    'Bank Mandiri',
    'Bank BJB'
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xffE4F9FF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Total saldo yang tersedia (Rp)'),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '10.000.000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Pilih No. rekening tujuan',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      items: bankItems.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item
                        ),
                      )).toList(),
                      validator: (value) {
                        if (value == null) {
                          return error;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 60,
                        padding: EdgeInsets.only(right: 10),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
              height: 170,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Saldo yang ditarik'),
                        Text('RpX.000.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Biaya Admin'),
                        Text('Rp4.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total'),
                        Text('RpX.000.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text(
                      "Withdraw",
                      style: TextStyle(
                        fontSize: 15,
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
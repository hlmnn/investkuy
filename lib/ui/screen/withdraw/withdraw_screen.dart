import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/rekening_model.dart';
import 'package:investkuy/ui/cubit/setting_cubit.dart';
import 'package:investkuy/ui/cubit/wallet_cubit.dart';
import 'package:investkuy/ui/screen/withdraw/withdraw_confirrm_screen.dart';
import 'package:investkuy/utils/currency_format.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key, required this.title, required this.walletId});

  final String title;
  final int walletId;

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  var error = 'Mohon pilih No. rekening tujuan anda!';

  RekeningModel? selectedValue;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nominal = TextEditingController();
  static const _locale = 'id';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  void dispose() {
    _nominal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WalletCubit>(context).getWallet();
    BlocProvider.of<SettingCubit>(context).getAllRekening();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          BlocBuilder<WalletCubit, DataState>(
            builder: (context, state) {
              int balance = 0;
              if (state is SuccessState) {
                balance = state.data.balance;
              }
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffE4F9FF),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(
                      15.0,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Total saldo yang tersedia'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        CurrencyFormat.convertToIdr(balance, 0),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<SettingCubit, DataState>(
            builder: (context, state) {
              List<RekeningModel> items = [];
              if (state is SuccessState) {
                items = state.data;
              }

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        value: selectedValue,
                        items: items
                            .map((item) => DropdownMenuItem<RekeningModel>(
                                  value: item,
                                  child: Text(
                                      "${item.merchant.name} - ${item.noRekening}"),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return error;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          //Do something when changing the item if you want.
                          selectedValue = value;
                        },
                        onSaved: (value) {
                          selectedValue = value;
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: TextFormField(
                          controller: _nominal,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nominal tidak boleh kosong';
                            }
                            if (value.isNotEmpty &&
                                int.parse(value.replaceAll('.', '')) < 10000) {
                              return 'Minimal withdraw adalah Rp 10.001';
                            }
                            return null;
                          },
                          onChanged: (string) {
                            string = _formatNumber(string.replaceAll('.', ''));
                            _nominal.value = TextEditingValue(
                              text: string,
                              selection: TextSelection.collapsed(
                                offset: string.length,
                              ),
                            );
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xff146C94),
                              ),
                            ),
                            prefixText: "Rp ",
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 15,
                              top: 20,
                              bottom: 20,
                            ),
                            hintText: 'Nominal',
                            hintStyle: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<SettingCubit, DataState>(
        builder: (context, state) {
          return BottomAppBar(
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
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WithdrawConfirmScreen(
                          title: "Konfirmasi",
                          walletId: widget.walletId,
                          merchantId: selectedValue!.merchantId,
                          nominal: int.parse(
                            _nominal.text.replaceAll('.', ''),
                          ),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff19A7CE),
                  fixedSize: const Size(double.maxFinite, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Withdraw",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/merchant_model.dart';
import 'package:investkuy/ui/cubit/wallet_cubit.dart';
import 'package:investkuy/ui/screen/topup/topup_confirm_screen.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key, required this.title, required this.walletId});

  final String title;
  final int walletId;

  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  String error = 'Mohon pilih merchant yang tersedia.';
  String? selectedValue;
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
    BlocProvider.of<MerchantCubit>(context).getAllMerchants();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<MerchantCubit, DataState>(
        builder: (context, state) {
          List<MerchantModel> items = [];
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            items = state.data;
          }

          return Container(
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
                      'Merchant',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    items: items
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.name),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return error;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                      selectedValue = value.toString();
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
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: TextFormField(
                      controller: _nominal,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nominal tidak boleh kosong';
                        }
                        if (value.isNotEmpty &&
                            int.parse(value.replaceAll('.', '')) < 10000) {
                          return 'Minimal topup adalah Rp 10.001';
                        }
                        return null;
                      },
                      onChanged: (string) {
                        string = _formatNumber(string.replaceAll('.', ''));
                        _nominal.value = TextEditingValue(
                          text: string,
                          selection:
                              TextSelection.collapsed(offset: string.length),
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
                  ),
                ],
              ),
            ),
          );
        },
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
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopUpConfirmScreen(
                      title: "Selesaikan Pembayaran",
                      walletId: widget.walletId,
                      merchantId: int.parse(selectedValue!),
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
              fixedSize: const Size(double.maxFinite, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Bayar",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

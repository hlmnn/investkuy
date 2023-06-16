import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/merchant_model.dart';
import 'package:investkuy/ui/cubit/rekening_cubit.dart';
import 'package:investkuy/ui/cubit/setting_cubit.dart';

class TambahRekening extends StatefulWidget {
  const TambahRekening({super.key, required this.title});

  final String title;

  @override
  _TambahRekeningState createState() => _TambahRekeningState();
}

class _TambahRekeningState extends State<TambahRekening> {
  String error = 'Mohon pilih No. rekening tujuan anda!';
  String? selectedValue;
  final TextEditingController _rekening = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _rekening.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RekeningCubit>(context).getAllMerchants();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<RekeningCubit, DataState>(
        builder: (context, state) {
          List<MerchantModel> data = [];
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            if (state.data is bool) {
              context.read<RekeningCubit>().resetState();
            } else {
              data = state.data;
            }
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
                    items: data
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
                      controller: _rekening,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'No. Rekening tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xff146C94),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 15, top: 20, bottom: 20),
                        hintText: 'Nomor Rekening',
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
          child: BlocBuilder<SettingCubit, DataState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<RekeningCubit>().addRekening(int.parse(selectedValue!), _rekening.value.text);
                  }
                  if (state is SuccessState) {
                    BlocProvider.of<SettingCubit>(context).getAllRekening();
                    SnackBar snackBar = const SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('Anda berhasil menambahkan rekening baru.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (state is ErrorState) {
                    SnackBar snackBar = SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text(state.message),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  "Tambah Rekening",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

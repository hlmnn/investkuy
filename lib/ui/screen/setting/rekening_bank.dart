import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/rekening_model.dart';
import 'package:investkuy/ui/cubit/setting_cubit.dart';
import 'package:investkuy/ui/screen/setting/tambah_rekening_screen.dart';

class RekeningBank extends StatefulWidget {
  const RekeningBank({super.key, required this.title});

  final String title;

  @override
  _RekeningBankState createState() => _RekeningBankState();
}

class _RekeningBankState extends State<RekeningBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<SettingCubit, DataState>(
        builder: (context, state) {
          List<RekeningModel> data = [];
          if (state is InitialState) {
            context.read<SettingCubit>().getAllRekening();
          } else if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
              if (state.data is bool) {
                context.read<SettingCubit>().resetState();
              } else {
                data = state.data;
              }
          }

          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String nomorRekCensored =
                    "${data[index].noRekening.substring(0, data[index].noRekening.length - 4)}****"; // sensor 4 angka dibelakang
                return Card(
                  color: const Color(0xffE4F9FF),
                  child: ListTile(
                    title: Text(data[index].merchant.name),
                    subtitle: Text(nomorRekCensored),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<SettingCubit>().deleteRekening(data[index].id);
                        if (state is SuccessState && state.data is bool) {
                          SnackBar snackBar = const SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text('Anda berhasil menghapus rekening.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          context.read<SettingCubit>().resetState();
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
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
                  context.read<SettingCubit>().resetState();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const TambahRekening(title: 'Tambah Rekening'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff19A7CE),
                    fixedSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
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

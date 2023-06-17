import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/tarik_dana_cubit.dart';
import 'package:investkuy/ui/screen/umkm/umkm_navigation.dart';

class ConfirmationTarikDanaScreen extends StatelessWidget {
  const ConfirmationTarikDanaScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<TarikDanaCubit, DataState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Apakah Anda yakin ingin menarik dana crowdfunding?',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<TarikDanaCubit>().tarikDanaCf(id);

                      if (state is SuccessState) {
                        if (state.data is bool) {
                          SnackBar snackBar = const SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text("Tarik Dana Berhasil!"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UmkmNavigation(
                                          title: "UMKM Navigation",
                                        )));
                          });

                          // BlocProvider.of<UmkmRiwayatCfCubit>(context)
                          //     .getAllRiwayatCrowdfunding();
                        }
                      } else if (state is ErrorState) {
                        SnackBar snackBar = SnackBar(
                          duration: const Duration(seconds: 5),
                          content: Text(state.message),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 35),
                      backgroundColor:
                          const Color(0xff19A7CE), // Warna latar belakang
                    ),
                    child: const Text('Ya'),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {
                      // Aksi saat tombol "Tidak" ditekan
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(100, 35),
                        side: const BorderSide(color: Color(0xff19A7CE))),
                    child: const Text('Tidak'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

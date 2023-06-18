import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/bayar_cicilan_cubit.dart';
import 'package:investkuy/ui/cubit/tarik_dana_cubit.dart';
import 'package:investkuy/ui/screen/umkm/umkm_navigation.dart';
import 'package:investkuy/utils/currency_format.dart';

class ConfirmationBayarCicilanScreen extends StatelessWidget {
  const ConfirmationBayarCicilanScreen(
      {super.key, required this.id, required this.angsuran});

  final String id;
  final int angsuran;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bayar Cicilan'),
          backgroundColor: const Color(0xff19A7CE),
        ),
        body: BlocBuilder<BayarCicilanCubit, DataState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xffE4F9FF),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Nominal Pembayaran'),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            angsuran != 0
                                ? CurrencyFormat.convertToIdr(angsuran, 0)
                                : "0",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cara Bayar : ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  'Pembayaran dilakukan antar wallet aplikasi',
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Konfirmasi Pembayaran?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<BayarCicilanCubit>().bayarCicilan(id);

                          if (state is SuccessState) {
                            if (state.data is bool) {
                              SnackBar snackBar = const SnackBar(
                                duration: Duration(seconds: 5),
                                content: Text("Bayar Cicilan Berhasil!"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UmkmNavigation(
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
          },
        ));
  }
}

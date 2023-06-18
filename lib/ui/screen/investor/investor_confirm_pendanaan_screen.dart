import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/detail_umkm_cubit.dart';
import 'package:investkuy/ui/cubit/pendanaan_cubit.dart';
import 'package:investkuy/ui/cubit/wallet_cubit.dart';
import 'package:investkuy/utils/currency_format.dart';

class InvestorConfirmPendanaanScreen extends StatelessWidget {
  const InvestorConfirmPendanaanScreen(
      {super.key, required this.nominal, required this.name, required this.id});

  final int nominal;
  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PendanaanCubit, DataState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessState) {
              SnackBar snackBar = const SnackBar(
                duration: Duration(seconds: 5),
                content: Text(
                  "Anda berhasil melakukan pendanaan!",
                ),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                BlocProvider.of<DetailUmkmCubit>(context)
                    .getDetailUmkm(id.toString());
                BlocProvider.of<WalletCubit>(context).getWallet();
                context.read<PendanaanCubit>().resetState();
                Navigator.pop(context);
              });
            } else if (state is ErrorState) {
              SnackBar snackBar = SnackBar(
                duration: const Duration(seconds: 5),
                content: Text(state.message),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                context.read<PendanaanCubit>().resetState();
              });
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Apakah Anda yakin ingin mendanai $name dengan nominal ${CurrencyFormat.convertToIdr(nominal, 0)}?",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<PendanaanCubit>()
                              .postPendanaan(nominal.toString(), id);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 35),
                          backgroundColor: const Color(0xff19A7CE),
                        ),
                        child: const Text('Ya'),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(100, 35),
                          side: const BorderSide(
                            color: Color(0xff19A7CE),
                          ),
                        ),
                        child: const Text('Tidak'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

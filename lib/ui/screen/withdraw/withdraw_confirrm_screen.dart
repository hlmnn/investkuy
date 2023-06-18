import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/wallet_cubit.dart';

class WithdrawConfirmScreen extends StatefulWidget {
  const WithdrawConfirmScreen({
    super.key,
    required this.title,
    required this.walletId,
    required this.merchantId,
    required this.nominal,
  });

  final String title;
  final int walletId;
  final int nominal;
  final int merchantId;

  @override
  State<WithdrawConfirmScreen> createState() => _WithdrawConfirmScreenState();
}

class _WithdrawConfirmScreenState extends State<WithdrawConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<WithdrawCubit, DataState>(
          builder: (context, state) {
            if (state is SuccessState) {
              SnackBar snackBar = const SnackBar(
                duration: Duration(seconds: 5),
                content: Text("Anda berhasil melakukan withdraw!"),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                BlocProvider.of<WalletCubit>(context).getWallet();
                Navigator.pop(context);
              });
              context.read<WithdrawCubit>().resetState();
            } else if (state is ErrorState) {
              SnackBar snackBar = SnackBar(
                duration: const Duration(seconds: 5),
                content: Text(state.message),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                context.read<WithdrawCubit>().resetState();
              });
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Apakah Anda ingin melakukan withdraw?",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<WithdrawCubit>().withdraw(
                            widget.walletId,
                            widget.merchantId,
                            widget.nominal,
                          );
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

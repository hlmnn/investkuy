import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/wallet_cubit.dart';
import 'package:investkuy/utils/string_format.dart';

class TopUpConfirmScreen extends StatefulWidget {
  const TopUpConfirmScreen({
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
  State<TopUpConfirmScreen> createState() => _TopUpConfirmScreenState();
}

class _TopUpConfirmScreenState extends State<TopUpConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    String paymentCode = StringFormat.generateRandomString(16);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Silahkan Selesaikan Pembayaran Anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xffE4F9FF),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cara Bayar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                                'Anda hanya perlu melakukan pembayaran  via ATM, internet banking, atau Virtual Account berikut:'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                paymentCode,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(
                                      ClipboardData(text: paymentCode));
                                  SnackBar snackBar = const SnackBar(
                                    duration: Duration(seconds: 5),
                                    content:
                                        Text('Berhasil disalin ke clipboard.'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                icon: const Icon(Icons.copy_outlined),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<TopUpCubit, DataState>(
        builder: (context, state) {
          if (state is SuccessState) {
            SnackBar snackBar = const SnackBar(
              duration: Duration(seconds: 5),
              content: Text("Anda berhasil melakukan top up!"),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              BlocProvider.of<WalletCubit>(context).getWallet();
              Navigator.pop(context);
            });
            context.read<TopUpCubit>().resetState();
          } else if (state is ErrorState) {
            SnackBar snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              content: Text(state.message),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              context.read<TopUpCubit>().resetState();
            });
          }

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
                  context.read<TopUpCubit>().topUp(
                      widget.walletId, widget.merchantId, widget.nominal);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff19A7CE),
                  fixedSize: const Size(double.maxFinite, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Selesai",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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

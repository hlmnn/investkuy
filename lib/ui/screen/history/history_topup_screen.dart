import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/wallet_model.dart';
import 'package:investkuy/ui/cubit/wallet_cubit.dart';
import 'package:investkuy/utils/currency_format.dart';
import 'package:investkuy/utils/date_formatter.dart';
import 'package:investkuy/utils/string_format.dart';

class HistoryTopUp extends StatefulWidget {
  const HistoryTopUp({super.key, required this.title, required this.walletId});

  final String title;
  final int walletId;

  @override
  _HistoryTopUpState createState() => _HistoryTopUpState();
}

class _HistoryTopUpState extends State<HistoryTopUp> {
  Future refresh() async {
    BlocProvider.of<DebitHistoryCubit>(context).getDebits(widget.walletId);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DebitHistoryCubit>(context).getDebits(widget.walletId);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
        child: BlocBuilder<DebitHistoryCubit, DataState>(
          builder: (context, state) {
            List<DebitTransactionModel> items = [];
            if (state is LoadingState) {
              return RefreshIndicator(
                onRefresh: refresh,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is SuccessState) {
              items = state.data;
            }

            if (items.isEmpty) {
              return RefreshIndicator(
                onRefresh: refresh,
                child: ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          bottom: 5,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Anda tidak memiliki riwayat transaksi debit saat ini!",
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            Image.asset(
                              'assets/images/empty.png',
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return Card(
                    color: const Color(0xffE4F9FF),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Nominal'),
                                Text(
                                  CurrencyFormat.convertToIdr(item.amount, 0),
                                  style: const TextStyle(
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
                              children: [
                                const Text('Tanggal'),
                                Text(
                                  DateFormatter.convertToDate(item.createdAt),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Jenis'),
                              Text(
                                StringFormat.capitalizeAllWord(item.type),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

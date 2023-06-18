import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/history/history_topup_screen.dart';
import 'package:investkuy/ui/screen/history/history_withdraw_screen.dart';
import 'package:investkuy/ui/screen/register/register_screen.dart';

class History extends StatefulWidget {
  const History({super.key, required this.title, required this.walletId});

  final String title;
  final int walletId;

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          backgroundColor: const Color(0xff19A7CE),
          bottom: const TabBar(
            indicatorColor: Color(0xff19A7CE),
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: 'Credit',
              ),
              Tab(
                text: 'Debit',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HistoryWithdraw(
              title: 'History Withdraw',
              walletId: widget.walletId,
            ),
            HistoryTopUp(
              title: 'History Top Up',
              walletId: widget.walletId,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/investor/history_topup_screen.dart';
import 'package:investkuy/ui/screen/investor/history_withdraw_screen.dart';
import 'package:investkuy/ui/screen/register/register_screen.dart';

class History extends StatefulWidget {
  const History({super.key, required this.title});

  final String title;

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History'),
          backgroundColor: const Color(0xff19A7CE),
          bottom: const TabBar(
            indicatorColor: Color(0xff19A7CE),
            indicatorWeight: 5,
            tabs: [
              Tab(text: 'Withdraw'),
              Tab(text: 'Top Up',),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HistoryWithdraw(title: 'History Withdraw'),
            HistoryTopUp(title: 'History Top Up'),
          ],
        ),
      ),
    );
  }
}
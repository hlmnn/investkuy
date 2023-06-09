import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/investor/investor_riwayat_completed_screen.dart';
import 'package:investkuy/ui/screen/investor/investor_riwayat_inprogress_screen.dart';

class InvestorRiwayat extends StatefulWidget {
  const InvestorRiwayat({super.key, required this.title});

  final String title;

  @override
  _InvestorRiwayatState createState() => _InvestorRiwayatState();
}

class _InvestorRiwayatState extends State<InvestorRiwayat> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
          bottom: const TabBar(
            indicatorColor: Color(0xff19A7CE),
            indicatorWeight: 5,
            tabs: [
              Tab(text: 'In Progress'),
              Tab(text: 'Completed',),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RiwayatInProgress(title: 'Riwayat In Progress'),
            RiwayatCompleted(title: 'Riwayat Completed'),
          ],
        ),
      ),
    );
  }
}
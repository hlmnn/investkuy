import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/notification/notifikasi_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_riwayat_crowdfunding_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_riwayat_payment_screen.dart';

class UmkmRiwayat extends StatefulWidget {
  const UmkmRiwayat({super.key, required this.title});

  final String title;

  @override
  _UmkmRiwayatState createState() => _UmkmRiwayatState();
}

class _UmkmRiwayatState extends State<UmkmRiwayat> {
  
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
              Tab(text: 'Crowdfunding'),
              Tab(
                text: 'Payment',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RiwayatCrowdfunding(title: 'Riwayat Crowdfunding'),
            RiwayatPayment(title: 'Riwayat Payment'),
          ],
        ),
      ),
    );
  }
}

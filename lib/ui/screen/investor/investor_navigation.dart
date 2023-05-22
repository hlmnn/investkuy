import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/investor/investor_home_screen.dart';
import 'package:investkuy/ui/screen/investor/investor_profile_screen.dart';
import 'package:investkuy/ui/screen/investor/investor_riwayat_screen.dart';
import 'package:investkuy/ui/screen/investor/investor_umkm_screen.dart';

class InvestorNavigation extends StatefulWidget {
  const InvestorNavigation({super.key, required this.title});

  final String title;

  @override
  _InvestorNavigationState createState() => _InvestorNavigationState();
}

class _InvestorNavigationState extends State<InvestorNavigation> {
  int pageIndex = 0; //index yang aktif
  //event saat button di-tap
  void onItemTap(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: pages(pageIndex),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: pageIndex,
              selectedItemColor: const Color(0xff19A7CE),
              type: BottomNavigationBarType.fixed,
              onTap: onItemTap, //event saat button di tap
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Beranda'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group),
                    label: "UMKM"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.credit_card),
                    label: "Riwayat"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_rounded),
                    label: "Profile"
                ),
              ]
          ),
        )
    );
  }

  pages(int pageIndex) {
    switch (pageIndex) {
      case 0:
        {
          return const InvestorHome(title: 'Beranda');
        }
      case 1:
        {
          return const InvestorUmkm(title: 'UMKM');
        }
      case 2:
        {
          return const InvestorRiwayat(title: 'Riwayat');
        }
      case 3:
        {
          return const InvestorProfile(title: 'Profile');
        }
    }
  }
}
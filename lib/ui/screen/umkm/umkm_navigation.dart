import 'package:flutter/material.dart';
import 'package:investkuy/ui/screen/umkm/umkm_home_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_profile_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_riwayat_screen.dart';

class UmkmNavigation extends StatefulWidget {
  const UmkmNavigation({super.key, required this.title});

  final String title;

  @override
  _UmkmNavigationState createState() => _UmkmNavigationState();
}

class _UmkmNavigationState extends State<UmkmNavigation> {
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
          return const UmkmHome(title: 'Beranda');
        }
      case 1:
        {
          return const UmkmRiwayat(title: 'Riwayat');
        }
      case 2:
        {
          return const UmkmProfile(title: 'Profile');
        }
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/ui/screen/notification/notifikasi_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_riwayat_crowdfunding_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_riwayat_payment_screen.dart';

import '../../../data/data_state.dart';
import '../../cubit/addnewpengajuan.cubit.dart';

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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xff19A7CE),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message_rounded),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Notifikasi(title: 'Notifikasi'))
                );
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Color(0xff19A7CE),
            indicatorWeight: 5,
            tabs: [
              Tab(text: 'Crowdfunding'),
              Tab(text: 'Payment',),
            ],
          ),
        ),
        body: BlocBuilder<AddNewPengajuanCubit, DataState>(
          builder: (context, state) {
           String? username;

          if (state is InitialState) {
            context.read<AddNewPengajuanCubit>().getUsername();
          }

          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessState) {
            username = state.data;
            context.read<AddNewPengajuanCubit>().resetState();
          }

          return TabBarView(
            children: [
              RiwayatCrowdfunding(title: 'Riwayat Crowdfunding', username: username),
              RiwayatPayment(title: 'Riwayat Payment'),
            ],
          );
        }
        )     
      ),
    );
  }
}
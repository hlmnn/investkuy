import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/add_laporan_cubit.dart';
import 'package:investkuy/ui/cubit/addnewpengajuan.cubit.dart';
import 'package:investkuy/ui/cubit/detail_umkm_cubit.dart';
import 'package:investkuy/ui/cubit/faq_cubit.dart';
import 'package:investkuy/ui/cubit/article_cubit.dart';
import 'package:investkuy/ui/cubit/investor_riwayat_cubit.dart';
import 'package:investkuy/ui/cubit/list_investor_cubit.dart';
import 'package:investkuy/ui/cubit/list_laporan_cubit.dart';
import 'package:investkuy/ui/cubit/list_umkm_cubit.dart';
import 'package:investkuy/ui/cubit/login_cubit.dart';
import 'package:investkuy/ui/cubit/pdf_cubit.dart';
import 'package:investkuy/ui/cubit/profile_cubit.dart';
import 'package:investkuy/ui/cubit/register_cubit.dart';
import 'package:investkuy/ui/cubit/rekening_cubit.dart';
import 'package:investkuy/ui/cubit/setting_cubit.dart';
import 'package:investkuy/ui/cubit/details_article_cubit.dart';
import 'package:investkuy/ui/cubit/splash_cubit.dart';
import 'package:investkuy/ui/cubit/umkm_home_cubit.dart';
import 'package:investkuy/ui/cubit/umkm_riwayat_cubit.dart';
import 'package:investkuy/ui/cubit/update_account_cubit.dart';
import 'package:investkuy/ui/cubit/verification_cubit.dart';
import 'package:investkuy/ui/screen/investor/investor_navigation.dart';
import 'package:investkuy/ui/screen/umkm/umkm_navigation.dart';
import 'package:investkuy/ui/screen/visitor/visitor_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<SettingCubit>(
          create: (context) => SettingCubit(),
        ),
        BlocProvider<RekeningCubit>(
          create: (context) => RekeningCubit(),
        ),
        BlocProvider<FaqCubit>(
          create: (context) => FaqCubit(),
        ),
        BlocProvider<ArticleCubit>(
          create: (context) => ArticleCubit(),
        ),
        BlocProvider<DetailsArticleCubit>(
          create: (context) => DetailsArticleCubit(),
        ),
        BlocProvider<AddNewPengajuanCubit>(
          create: (context) => AddNewPengajuanCubit(),
        ),
        BlocProvider<ListUmkmCubit>(
          create: (context) => ListUmkmCubit(),
        ),
        BlocProvider<DetailUmkmCubit>(
          create: (context) => DetailUmkmCubit(),
        ),
        BlocProvider<UpdateAccountCubit>(
          create: (context) => UpdateAccountCubit(),
        ),
        BlocProvider<UmkmRiwayatCfCubit>(
          create: (context) => UmkmRiwayatCfCubit(),
        ),
        BlocProvider<UmkmRiwayatPaymentCubit>(
          create: (context) => UmkmRiwayatPaymentCubit(),
        ),
        BlocProvider<VerificationCubit>(
          create: (context) => VerificationCubit(),
        ),
        BlocProvider<InvestorRiwayatInProgressCubit>(
          create: (context) => InvestorRiwayatInProgressCubit(),
        ),
        BlocProvider<InvestorRiwayatCompletedCubit>(
          create: (context) => InvestorRiwayatCompletedCubit(),
        ),
        BlocProvider<ListInvestorCubit>(
          create: (context) => ListInvestorCubit(),
        ),
        BlocProvider<AddLaporanCubit>(
          create: (context) => AddLaporanCubit(),
        ),
        BlocProvider<ListLaporanCubit>(
          create: (context) => ListLaporanCubit(),
        ),
        BlocProvider<PdfCubit>(
          create: (context) => PdfCubit(),
        ),
        BlocProvider<UmkmHomeCubit>(
          create: (context) => UmkmHomeCubit(),
        ),
      ],
      child: const MaterialApp(
        home: SplashScreen(title: 'SplashScreen'),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashCubit>(context).getCurrentUserRole();
    return Container(
      color: Colors.white,
      child: BlocBuilder<SplashCubit, DataState>(
        builder: (context, state) {
          Timer(const Duration(seconds: 5), () {
            if (state is SuccessState) {
              if (state.data == "Visitor") {
                context.read<SplashCubit>().resetState();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const VisitorNavigation(title: 'VisitorNavigation'),
                  ),
                );
              } else if (state.data == "Investor") {
                context.read<SplashCubit>().resetState();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const InvestorNavigation(title: 'Investor Navigation'),
                  ),
                );
              } else {
                context.read<SplashCubit>().resetState();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const UmkmNavigation(title: 'UMKM Navigation'),
                  ),
                );
              }
            }
          });

          return Image.asset('assets/images/logo.png');
        },
      ),
    );
  }
}

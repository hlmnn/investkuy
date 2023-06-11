import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/faq_cubit.dart';
import 'package:investkuy/ui/cubit/article_cubit.dart';
import 'package:investkuy/ui/cubit/login_cubit.dart';
import 'package:investkuy/ui/cubit/profile_cubit.dart';
import 'package:investkuy/ui/cubit/register_cubit.dart';
import 'package:investkuy/ui/cubit/rekening_cubit.dart';
import 'package:investkuy/ui/cubit/setting_cubit.dart';
import 'package:investkuy/ui/cubit/details_article_cubit.dart';
import 'package:investkuy/ui/cubit/splash_cubit.dart';
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
        )
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
    return Container(
      color: Colors.white,
      child: BlocBuilder<SplashCubit, DataState>(
        builder: (context, state) {
          if (state is InitialState) {
            context.read<SplashCubit>().getCurrentUserRole();
          }
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

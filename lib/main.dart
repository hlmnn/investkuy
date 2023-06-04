import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/ui/screen/investor/investor_navigation.dart';
import 'package:investkuy/ui/screen/login/login_cubit.dart';
import 'package:investkuy/ui/screen/register/register_cubit.dart';
import 'package:investkuy/ui/screen/visitor/visitor_navigation.dart';

import 'data/repository/auth_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(repository: AuthRepository()),
          ),
          BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(repository: AuthRepository()),
          )
        ],
        child: const MaterialApp(
          home: SplashScreen(title: 'Splash Screen'),
        )
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
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () =>
        Navigator.pushReplacement(
          context,
          // MaterialPageRoute(builder: (context) => const InvestorNavigation(title: 'InvestorNavigation'))
          MaterialPageRoute(builder: (context) => const VisitorNavigation(title: 'VisitorNavigation'))
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Image.asset('assets/images/logo.png')
    );
  }
}

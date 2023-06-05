import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/screen/investor/investor_navigation.dart';
import 'package:investkuy/ui/screen/login/login_cubit.dart';
import 'package:investkuy/ui/screen/register/register_screen.dart';
import 'package:investkuy/ui/screen/umkm/umkm_navigation.dart';
import 'package:investkuy/ui/screen/visitor/visitor_navigation.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObsecure = true;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<LoginCubit, DataState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is SuccessState) {
              if (state.data.role == 'Investor') {
                Future.delayed(Duration.zero,(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InvestorNavigation(title: 'Investor Navigation')),
                  );
                });

              } else {
                Future.delayed(Duration.zero,(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UmkmNavigation(title: 'UMKM Navigation')),
                  );
                });
              }
            }  

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image
                    Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Image.asset('assets/images/logo.png')
                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Username
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: TextFormField(
                              controller: _username,
                              validator: (value) {
                                return (value == null || value.isEmpty) ? 'Username must not be empty!' : null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff146C94)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Username',
                                hintStyle: TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          // Password
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                              controller: _password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password must not be empty';
                                }
                                if ((value.isNotEmpty) && value.length < 6) {
                                  return 'Password must at least 6 characters long';
                                }
                                return null;
                              },
                              obscureText: _isObsecure,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff146C94)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 14,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_isObsecure ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObsecure = !_isObsecure;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Button
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed:  () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(_username.value.text, _password.value.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff19A7CE),
                            fixedSize: const Size(220, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        child: const Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    // Text and TextButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Register(title: 'Register')),
                            );
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent
                          ),
                          child: const Text(
                            "Daftar disini!",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

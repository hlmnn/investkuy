import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/register_cubit.dart';
import 'package:investkuy/ui/screen/visitor/login_choice_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.title});

  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _pin = TextEditingController();
  final TextEditingController _confirmPin = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscurePass1 = true;
  bool isObscurePass2 = true;
  bool isChecked = false;
  bool register = false;

  @override
  void dispose() {
    _username.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _pin.dispose();
    _confirmPin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<RegisterCubit, DataState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is SuccessState) {
              context.read<RegisterCubit>().resetState();
              Future.delayed(Duration.zero, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginChoice(title: 'LoginChoice'))
                );
              });
            }  
            
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image
                    Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Image.asset('assets/images/logo.png')),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Nama
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: TextFormField(
                              controller: _name,
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Nama tidak boleh kosong!'
                                    : null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff146C94)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Nama',
                                hintStyle: TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          // Email
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _email,
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Email tidak boleh kosong!'
                                    : null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff146C94)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          // Username
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _username,
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Username tidak boleh kosong!'
                                    : null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff146C94)),
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _password,
                              obscureText: isObscurePass1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if ((value.isNotEmpty) && value.length < 8) {
                                  return 'Password setidaknya memiliki panjang 8 karakter';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff146C94)),
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
                                    icon: Icon(isObscurePass1
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        isObscurePass1 = !isObscurePass1;
                                      });
                                    },
                                  )),
                            ),
                          ),

                          // Repeat Password
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _confirmPassword,
                              obscureText: isObscurePass2,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Password tidak boleh kosong';
                                }
                                if ((value.isNotEmpty) && value.length < 8) {
                                  return 'Confirm Password setidaknya memiliki panjang 8 karakter';
                                }
                                if ((value.isNotEmpty) &&
                                    value != _password.value.text) {
                                  return 'Confirm Password tidak cocok dengan Password!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff146C94)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: 'Masukan kembali password',
                                  hintStyle: const TextStyle(
                                    color: Color(0xff4A4A4A),
                                    fontSize: 14,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(isObscurePass2
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        isObscurePass2 = !isObscurePass2;
                                      });
                                    },
                                  )),
                            ),
                          ),

                          // PIN
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _pin,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'PIN tidak boleh kosong';
                                }
                                if ((value.isNotEmpty) && value.length < 6) {
                                  return 'PIN setidaknya memiliki panjang 6 karakter';
                                }
                                return null;
                              },
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff146C94)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'PIN',
                                hintStyle: TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 14,
                                ),
                              ),
                              maxLength: 6,
                            ),
                          ),
                          // Confirm PIN
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _confirmPin,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm PIN tidak boleh kosong';
                                }
                                if ((value.isNotEmpty) && value.length < 6) {
                                  return 'Confirm PIN setidaknya memiliki panjang 6 karakter';
                                }
                                if ((value.isNotEmpty) &&
                                    value != _pin.value.text) {
                                  return 'Confirm PIN tidak cocok dengan PIN!';
                                }
                                return null;
                              },
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff146C94)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Masukan kembali PIN',
                                hintStyle: TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 14,
                                ),
                              ),
                              maxLength: 6,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Expanded(
                            child: Text(
                                'Saya telah menyetujui Syarat & Ketentuan yang berlaku.'))
                      ],
                    ),

                    // Button Register Now!
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          var snackBar;
                          if (isChecked) {
                            if (_formKey.currentState!.validate()) {
                              context.read<RegisterCubit>().register(
                                  _name.value.text,
                                  _email.value.text,
                                  _username.value.text,
                                  _password.value.text,
                                  _confirmPassword.value.text,
                                  _pin.value.text,
                                  widget.title);
                            }
                            if (state is ErrorState) {
                              snackBar = SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(state.message),
                              );
                            }
                          } else {
                            snackBar = const SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text("Silahkan menyetujui Syarat & Ketentuan yang berlaku terlebih dahulu."),
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff19A7CE),
                            fixedSize: const Size(double.maxFinite, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Daftar Sekarang!",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
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

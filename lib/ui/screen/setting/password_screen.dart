import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/setting_cubit.dart';

class Password extends StatefulWidget {
  const Password({super.key, required this.title});

  final String title;

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  final TextEditingController _confNewPass = TextEditingController();
  final TextEditingController _pin = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isObscurePass1 = true;
  bool isObscurePass2 = true;
  bool isObscurePass3 = true;

  @override
  void dispose() {
    _oldPass.dispose();
    _newPass.dispose();
    _confNewPass.dispose();
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<SettingCubit, DataState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            _oldPass.clear();
            _newPass.clear();
            _confNewPass.clear();
            _pin.clear();
            context.read<SettingCubit>().resetState();
            Future.delayed(Duration.zero, () {
              Navigator.pop(context);
            });
          }

          return Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _oldPass,
                    obscureText: isObscurePass1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password lama tidak boleh kosong';
                      }
                      if ((value.isNotEmpty) && value.length < 8) {
                        return 'Password lama setidaknya memiliki panjang 8 karakter';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff146C94),
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        top: 20,
                        bottom: 20,
                      ),
                      hintText: 'Password Lama',
                      hintStyle: const TextStyle(
                        fontSize: 15,
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: TextFormField(
                      controller: _newPass,
                      obscureText: isObscurePass2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password baru tidak boleh kosong';
                        }
                        if ((value.isNotEmpty) && value.length < 8) {
                          return 'Password baru setidaknya memiliki panjang 8 karakter';
                        }
                        if (value.isNotEmpty && value == _oldPass.value.text) {
                          return 'password baru tidak boleh sama dengan password lama';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xff146C94),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                          bottom: 20,
                        ),
                        hintText: 'Password Baru',
                        hintStyle: const TextStyle(
                          fontSize: 15,
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
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: _confNewPass,
                      obscureText: isObscurePass3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi password tidak boleh kosong';
                        }
                        if ((value.isNotEmpty) && value.length < 8) {
                          return 'Konfirmasi password setidaknya memiliki panjang 8 karakter';
                        }
                        if (value.isNotEmpty && value != _newPass.value.text) {
                          return 'Password dan konfirmasi password tidak sesuai.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xff146C94),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                          bottom: 20,
                        ),
                        hintText: 'Masukan Kembali Password Baru',
                        hintStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(isObscurePass3
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isObscurePass3 = !isObscurePass3;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: _pin,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'PIN tidak boleh kosong';
                        }
                        if ((value.isNotEmpty) && value.length < 6) {
                          return 'PIN setidaknya memiliki panjang 6 digit';
                        }
                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xff146C94),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                          bottom: 20,
                        ),
                        hintText: 'PIN',
                        hintStyle: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      maxLength: 6,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 90,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          child: BlocBuilder<SettingCubit, DataState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SettingCubit>().changePassword(
                          _oldPass.value.text,
                          _newPass.value.text,
                          _confNewPass.value.text,
                          _pin.value.text,
                        );
                  }
                  if (state is SuccessState) {
                    SnackBar snackBar = const SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('Anda berhasil mengganti password.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (state is ErrorState) {
                    SnackBar snackBar = SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text(state.message),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff19A7CE),
                  fixedSize: const Size(double.maxFinite, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Ubah Password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

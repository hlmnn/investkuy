import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/setting_cubit.dart';

class Pin extends StatefulWidget {
  const Pin({super.key, required this.title});

  final String title;

  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  final TextEditingController _oldPin = TextEditingController();
  final TextEditingController _newPin = TextEditingController();
  final TextEditingController _confNewPin = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isObscurePass1 = true;

  @override
  void dispose() {
    _oldPin.dispose();
    _newPin.dispose();
    _confNewPin.dispose();
    _password.dispose();
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
            _oldPin.clear();
            _newPin.clear();
            _confNewPin.clear();
            _password.clear();
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
                    controller: _oldPin,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PIN lama tidak boleh kosong';
                      }
                      if ((value.isNotEmpty) && value.length < 6) {
                        return 'PIN lama setidaknya memiliki panjang 6 digit';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      hintText: 'PIN Lama',
                      hintStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    maxLength: 6,
                  ),
                  TextFormField(
                    controller: _newPin,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PIN baru tidak boleh kosong';
                      }
                      if ((value.isNotEmpty) && value.length < 6) {
                        return 'PIN baru setidaknya memiliki panjang 6 digit';
                      }
                      if (value.isNotEmpty && value == _oldPin.value.text) {
                        return 'PIN baru tidak boleh sama dengan PIN lama';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      hintText: 'PIN Baru',
                      hintStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    maxLength: 6,
                  ),
                  TextFormField(
                    controller: _confNewPin,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi PIN tidak boleh kosong';
                      }
                      if ((value.isNotEmpty) && value.length < 6) {
                        return 'Konfirmasi PIN setidaknya memiliki panjang 6 digit';
                      }
                      if (value.isNotEmpty && value != _newPin.value.text) {
                        return 'Konfirmasi PIN tidak sama dengan PIN baru';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      hintText: 'Masukan Kembali PIN Baru',
                      hintStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    maxLength: 6,
                  ),
                  TextFormField(
                    controller: _password,
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
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      hintText: 'Password',
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
                    context.read<SettingCubit>().changePin(
                        _oldPin.value.text,
                        _newPin.value.text,
                        _confNewPin.value.text,
                        _password.value.text);
                  }
                  if (state is SuccessState) {
                    SnackBar snackBar = const SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('Anda berhasil mengganti pin.'),
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
                  "Ubah PIN",
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

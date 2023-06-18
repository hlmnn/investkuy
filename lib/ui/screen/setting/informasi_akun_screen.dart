import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/user_model.dart';
import 'package:investkuy/ui/cubit/profile_cubit.dart';
import 'package:investkuy/ui/cubit/update_account_cubit.dart';

class InformasiAkun extends StatefulWidget {
  const InformasiAkun({super.key, required this.title});

  final String title;

  @override
  _InformasiAkunState createState() => _InformasiAkunState();
}

class _InformasiAkunState extends State<InformasiAkun> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingFilePickerController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _noTelp = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageTemp = File(image.path);
        textEditingFilePickerController.text = image.name;
        setState(() => this.image = imageTemp);
      } else {
        log("No image is selected.");
      }
    } catch (e) {
      log("Failed to pick image: $e");
    }
  }

  @override
  void dispose() {
    textEditingFilePickerController.dispose();
    _name.dispose();
    _email.dispose();
    _noTelp.dispose();
    _alamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UpdateAccountCubit>(context).getUser();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<UpdateAccountCubit, DataState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            if (state.data is UserModel) {
              _name.text = state.data.name;
              _email.text = state.data.email;
              _noTelp.text = state.data.telp;
              _alamat.text = state.data.alamat;
            }
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color(0xff146C94)),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: image != null
                          ? Image.file(
                        image!,
                        fit: BoxFit.fill,
                      )
                          : const Align(
                        alignment: Alignment.center,
                        child: Text('No image selected'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xff146C94)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Upload Foto',
                                hintStyle: TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 14,
                                ),
                              ),
                              controller: textEditingFilePickerController,
                            ),
                          ),
                          const SizedBox(width: 5),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.upload_file,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            label: const Text('Pilih Foto'),
                            onPressed: () {
                              pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff19A7CE),
                              minimumSize: const Size(122, 48),
                              maximumSize: const Size(122, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: TextFormField(
                        controller: _name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama tidak boleh kosong!";
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
                          hintText: 'Nama',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email tidak boleh kosong!";
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
                              left: 15, top: 20, bottom: 20),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _noTelp,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "No. Handphone tidak boleh kosong!";
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
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            top: 20,
                            bottom: 20,
                          ),
                          hintText: 'No. Handphone',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _alamat,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Alamat tidak boleh kosong!";
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
                          hintText: 'Alamat',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
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
          child: BlocBuilder<UpdateAccountCubit, DataState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FormData formData = FormData();
                    formData.fields.addAll([
                      MapEntry('name', _name.value.text),
                      MapEntry('email', _email.value.text),
                      MapEntry('no_telepon', _noTelp.value.text),
                      MapEntry('alamat', _alamat.value.text),
                    ]);
                    context.read<UpdateAccountCubit>().updateAccount(formData, image!.path);
                  }

                  var snackBar;
                  if (state is ErrorState) {
                    snackBar = SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text(state.message),
                    );
                    context.read<UpdateAccountCubit>().resetState();
                  } if (state is SuccessState) {
                    snackBar = const SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text("Anda berhasil mengubah informasi akun"),
                    );
                    Future.delayed(const Duration(seconds: 1), () {
                      BlocProvider.of<ProfileCubit>(context).getUser();
                      Navigator.pop(context);
                    });
                    context.read<UpdateAccountCubit>().resetState();
                  }

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff19A7CE),
                  fixedSize: const Size(double.maxFinite, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Ubah Informasi Akun",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}

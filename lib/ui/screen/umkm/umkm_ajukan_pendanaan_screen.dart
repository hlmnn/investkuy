import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/ui/cubit/add_pengajuan_cubit.dart';
import 'package:investkuy/data/data_state.dart';

class UmkmAjukanPendanaan extends StatefulWidget {
  const UmkmAjukanPendanaan({super.key, required this.title});

  final String title;

  @override
  _UmkmAjukanPendanaanState createState() => _UmkmAjukanPendanaanState();
}

class _UmkmAjukanPendanaanState extends State<UmkmAjukanPendanaan> {
  final _formKey = GlobalKey<FormState>();

  final textEditingPekerjaanController = TextEditingController();
  final textEditingPenghasilanController = TextEditingController();
  final textEditingDeskripsiController = TextEditingController();
  final textEditingFilePickerController = TextEditingController();
  final textEditingImagePickerController = TextEditingController();
  TextEditingController textEditingAkadController = TextEditingController();

  String _pekerjaan = "";
  String _deskripsi = "";
  String _akad = "";
  String? fileLaporan;
  List<String>? fileImages;
  List<String>? fileImagesName;

  String? selectedSectorValue,
      selectedAngsuranValue,
      selectedPenghasilanValue,
      selectedPlafondValue,
      selectedTenorValue,
      selectedImbahValue;
  String? selectedSectorValueOut,
      selectedAngsuranValueOut,
      selectedPenghasilanValueOut,
      selectedPlafondValueOut,
      selectedTenorValueOut,
      selectedImbahValueOut;

  var error = 'Mohon pilih No. rekening tujuan anda!';

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      setState(() {
        textEditingFilePickerController.text = result.files.single.name;
        fileLaporan = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  void _pickMultipleImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: true);

    if (result != null) {
      String fileNamesPlaceHolder =
          result.files.map((file) => file.name).join(", ");
      textEditingImagePickerController.text = fileNamesPlaceHolder;

      fileImagesName = result.files.map((file) => file.name).toList();
      fileImages = result.paths.map((path) => path!).toList();
      log(fileImages![0]);
      log(fileImagesName![0]);
    } else {
      // User canceled the picker
    }
  }

  @override
  void dispose() {
    textEditingPekerjaanController.dispose();
    textEditingPenghasilanController.dispose();
    textEditingDeskripsiController.dispose();
    textEditingFilePickerController.dispose();
    textEditingImagePickerController.dispose();
    textEditingAkadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textEditingAkadController.text = "Jual Beli";
    String snackbarText = "";

    List<DropdownMenuItem<String>> sectorItems = [
      const DropdownMenuItem<String>(
        value: "perdagangan",
        child: Text("perdagangan"),
      ),
      const DropdownMenuItem<String>(
        value: "jasa",
        child: Text("jasa"),
      ),
      const DropdownMenuItem<String>(
        value: "pertanian",
        child: Text("pertanian"),
      ),
      const DropdownMenuItem<String>(
        value: "peternakan",
        child: Text("peternakan"),
      )
    ];

    List<DropdownMenuItem<String>> penghasilanItems = [
      const DropdownMenuItem<String>(
        value: 'Kurang dari Rp 500.000',
        child: Text("Kurang dari Rp 500.000"),
      ),
      const DropdownMenuItem<String>(
        value: 'Rp 500.001 - Rp 2.500.000',
        child: Text("Rp 500.001 - Rp 2.000.000"),
      ),
      const DropdownMenuItem<String>(
        value: 'Rp 2.500.001 - Rp 5.000.000',
        child: Text("Rp 2.500.001 - Rp 5.000.000"),
      ),
      const DropdownMenuItem<String>(
        value: 'Lebih dari Rp 5.000.000',
        child: Text("Lebih dari Rp 5.000.000"),
      ),
    ];

    List<DropdownMenuItem<String>> plafondItems = [
      const DropdownMenuItem<String>(
        value: '1000000',
        child: Text("Rp 1.000.000"),
      ),
      const DropdownMenuItem<String>(
        value: '2000000',
        child: Text("Rp 2.000.000"),
      ),
      const DropdownMenuItem<String>(
        value: '3000000',
        child: Text("Rp 3.000.000"),
      ),
      const DropdownMenuItem<String>(
        value: '4000000',
        child: Text("Rp 4.000.000"),
      ),
      const DropdownMenuItem<String>(
        value: '5000000',
        child: Text("Rp 5.000.000"),
      ),
    ];

    List<DropdownMenuItem<String>> tenorItems = [
      const DropdownMenuItem<String>(
        value: '25',
        child: Text("25 Minggu"),
      ),
      const DropdownMenuItem<String>(
        value: '50',
        child: Text("50 Minggu"),
      ),
    ];

    List<DropdownMenuItem<String>> bagiHasilItems = [
      const DropdownMenuItem<String>(
        value: '11',
        child: Text("11%"),
      ),
      const DropdownMenuItem<String>(
        value: '12',
        child: Text("12%"),
      ),
      const DropdownMenuItem<String>(
        value: '13',
        child: Text("13%"),
      ),
    ];

    List<DropdownMenuItem<String>> jenisAngsuranItems = [
      const DropdownMenuItem<String>(
        value: "mingguan",
        child: Text("Mingguan"),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<AddNewPengajuanCubit, DataState>(
          builder: (context, state) {
        if (state is LoadingState) {
          log("TES");
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          var snackBar = const SnackBar(
            duration: Duration(seconds: 5),
            content: Text("Membuat pengajuan pendanaan Berhasil!"),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.read<AddNewPengajuanCubit>().resetState();
            Navigator.pop(context);
          });
        } else if (state is ErrorState) {
          var snackBar = SnackBar(
            duration: const Duration(seconds: 5),
            content: Text(state.message),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.read<AddNewPengajuanCubit>().resetState();
          });
        }

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    color: const Color(0xffE4F9FF),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Masukan Informasi UMKM",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Pekerjaan
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: TextFormField(
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
                              hintText: 'Pekerjaan',
                              hintStyle: TextStyle(
                                color: Color(0xff4A4A4A),
                                fontSize: 14,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pekerjaan harus diisi!';
                              }
                              return null;
                            },
                            controller: textEditingPekerjaanController,
                          ),
                        ),
                        // Sektor
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xff666666), width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonFormField(
                                hint: const Text("Sektor"),
                                items: sectorItems,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mohon Pilih Sektor Usaha anda!';
                                  }
                                  return null;
                                },
                                value: selectedSectorValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedSectorValue = value;
                                    }
                                  });
                                },
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A4A4A),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Penghasilan Perbulan
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xff666666), width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonFormField(
                                hint: const Text("Penghasilan Perbulan"),
                                items: penghasilanItems,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukan Penghasilan Usaha anda!';
                                  }
                                  return null;
                                },
                                value: selectedPenghasilanValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedPenghasilanValue = value;
                                    }
                                  });
                                },
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A4A4A),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Deskripsi UMKM
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: TextFormField(
                            maxLength: 200,
                            maxLines: 5,
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
                              hintText: 'Deskripsi UMKM',
                              hintStyle: TextStyle(
                                color: Color(0xff4A4A4A),
                                fontSize: 14,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Deskripsi tidak boleh kosong!';
                              }
                              return null;
                            },
                            controller: textEditingDeskripsiController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // foto
                  Container(
                    color: const Color(0xffE4F9FF),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tambahkan foto UMKM (3 Foto)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Foto UMKM tidak boleh kosong!';
                                    } else {
                                      List<String> splitValue =
                                          value.split(", ");
                                      if (splitValue.length != 3) {
                                        return 'Anda Harus memasukan tepat 3 Foto UMKM Anda';
                                      }
                                    }
                                    return null;
                                  },
                                  controller: textEditingImagePickerController,
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
                                  _pickMultipleImage();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff19A7CE),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    color: const Color(0xffE4F9FF),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Masukan Informasi Pendanaan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Plafond
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xff666666), width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonFormField(
                                hint: const Text("Plafond"),
                                items: plafondItems,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harap Pilih Plafond untuk peminjaman!';
                                  }
                                  return null;
                                },
                                value: selectedPlafondValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedPlafondValue = value;
                                    }
                                  });
                                },
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A4A4A),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Tenor Pendanaan
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xff666666), width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonFormField(
                                hint: const Text("Tenor Pendanaan (Minggu)"),
                                items: tenorItems,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harap Pilih Tenor untuk peminjaman!';
                                  }
                                  return null;
                                },
                                value: selectedTenorValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedTenorValue = value;
                                    }
                                  });
                                },
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A4A4A),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Imbah Hasil
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xff666666), width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonFormField(
                                hint: const Text("Imbah Hasil"),
                                items: bagiHasilItems,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harap Pilih Besar Imbah Hasil untuk peminjaman!';
                                  }
                                  return null;
                                },
                                value: selectedImbahValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedImbahValue = value;
                                    }
                                  });
                                },
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A4A4A),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Jenis Angsuran
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xff666666), width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonFormField(
                                hint: const Text("Jenis Angsuran"),
                                items: jenisAngsuranItems,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harap Pilih jenis angsuran untuk peminjaman!';
                                  }
                                  return null;
                                },
                                value: selectedAngsuranValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedAngsuranValue = value;
                                    }
                                  });
                                },
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A4A4A),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Akad
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: TextFormField(
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
                              hintText: 'Akad',
                              hintStyle: TextStyle(
                                color: Color(0xff4A4A4A),
                                fontSize: 14,
                              ),
                              enabled: false,
                            ),
                            controller: textEditingAkadController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    color: const Color(0xffE4F9FF),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tambahkan Laporan Keuangan UMKM anda yang berupa file PDF (ukuran file maks 5MB)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Akad
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
                                    hintText: 'Upload File',
                                    hintStyle: TextStyle(
                                      color: Color(0xff4A4A4A),
                                      fontSize: 14,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Anda harus mencantumkan laporan keuangan usaha anda!';
                                    }
                                    return null;
                                  },
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
                                label: const Text('Pilih File'),
                                onPressed: () {
                                  _pickFile();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff19A7CE),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        // var snackBar;
                        if (_formKey.currentState!.validate()) {
                          FormData formData = FormData();
                          formData.fields.addAll([
                            MapEntry('pekerjaan',
                                textEditingPekerjaanController.text),
                            MapEntry('sektor', selectedSectorValue!),
                            MapEntry('deskripsi',
                                textEditingDeskripsiController.text),
                            MapEntry('penghasilan', selectedPenghasilanValue!),
                            MapEntry('plafond', selectedPlafondValue!),
                            MapEntry('tenor', selectedTenorValue!),
                            MapEntry('bagi_hasil', selectedImbahValue!),
                            MapEntry('jenis_angsuran', selectedAngsuranValue!),
                            MapEntry('akad', textEditingAkadController.text),
                          ]);

                          context.read<AddNewPengajuanCubit>().addPengajuan(
                              formData, fileImages!, fileLaporan!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff19A7CE),
                          fixedSize: const Size(double.maxFinite, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Posting Pendanaan",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

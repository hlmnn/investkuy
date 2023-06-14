import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/ui/cubit/addnewpengajuan.cubit.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/screen/umkm/umkm_riwayat_crowdfunding_screen.dart';

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
  final textEditingAkadController = TextEditingController();
  final textEditingFilePickerController = TextEditingController();
  final textEditingImagePickerController = TextEditingController();

  String _pekerjaan = "";
  String _deskripsi = "";
  String _akad = "";
  File? fileLaporan;
  Uint8List? fileLaporanBytes;
  List<File>? fileImages;
  List<Uint8List>? fileImagesBytes;

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
        fileLaporan = File(result.files.single.path.toString());
      });

      PlatformFile platformFiles = result.files.single;
      File file = File(platformFiles.path!);
      fileLaporanBytes = file.readAsBytes() as Uint8List?;
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
      String fileNames = result.files.map((file) => file.name).join(", ");
      textEditingImagePickerController.text = fileNames;
      fileImages = result.paths.map((path) => File(path!)).toList();

      List<PlatformFile> platformFiles = result.files;
      List<File> files = platformFiles
          .map((platformFile) => File(platformFile.path!))
          .toList();
      fileImages = files;

      for (File file in files) {
        fileImagesBytes?.add(file.readAsBytes() as Uint8List);
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  void dispose() {
    textEditingPekerjaanController.dispose();
    textEditingPenghasilanController.dispose();
    textEditingDeskripsiController.dispose();
    textEditingAkadController.dispose();
    textEditingFilePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        
        if (state is InitialState) {
          context.read<AddNewPengajuanCubit>().getUsername();
        }

        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          final String username = state.data;
          context.read<AddNewPengajuanCubit>().resetState();
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RiwayatCrowdfunding(
                        title: 'Riwayat Crowdfunding', username: username)));
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
                          "Tambahkan foto UMKM",
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
                        var snackBar;
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _pekerjaan = textEditingPekerjaanController.text;
                            _deskripsi = textEditingDeskripsiController.text;
                            _akad = textEditingAkadController.text;
                            selectedSectorValueOut = selectedSectorValue;
                            selectedPenghasilanValueOut =
                                selectedPenghasilanValue;
                            selectedTenorValueOut =
                                int.parse(selectedTenorValue!).toString();
                            selectedPlafondValueOut =
                                int.parse(selectedPlafondValue!).toString();
                            selectedImbahValueOut =
                                int.parse(selectedImbahValue!).toString();
                            selectedAngsuranValueOut = selectedAngsuranValue;
                          }); //refresh

                          FormData formData = FormData();
                          formData.fields.addAll([
                            MapEntry('pekerjaan', _pekerjaan),
                            MapEntry('sektor', selectedSectorValueOut!),
                            MapEntry('deskripsi', _deskripsi),
                            MapEntry(
                                'penghasilan', selectedPenghasilanValueOut!),
                            MapEntry('plafond', selectedPlafondValueOut!),
                            MapEntry('tenor', selectedTenorValueOut!),
                            MapEntry('bagi_hasil', selectedImbahValueOut!),
                            MapEntry(
                                'jenis_angsuran', selectedAngsuranValueOut!),
                            MapEntry('akad', _akad),
                          ]);

                          /* context.read<AddNewPengajuanCubit>().addPengajuan(
                              formData, fileImagesBytes!, fileLaporanBytes!); */

                          context.read<AddNewPengajuanCubit>().addPengajuan(
                              formData, fileImages!, fileLaporan!);
                        }
                        if (state is ErrorState) {
                          snackBar = SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text(state.message),
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => const LoginChoice(title: 'LoginChoice'))
                        // );
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

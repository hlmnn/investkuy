import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UmkmLaporanKeuangan extends StatefulWidget {
  const UmkmLaporanKeuangan({super.key, required this.title});

  final String title;

  @override
  _UmkmLaporanKeuanganState createState() => _UmkmLaporanKeuanganState();
}

class _UmkmLaporanKeuanganState extends State<UmkmLaporanKeuangan> {
  final _formKey = GlobalKey<FormState>();

  final textEditingFilePickerController = TextEditingController();

  File? fileLaporan;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      setState(() {
        textEditingFilePickerController.text = result.files.single.name;
        fileLaporan = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void dispose() {
    textEditingFilePickerController.dispose();
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    color: const Color(0xffE4F9FF),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tambahkan Laporan Keuangan UMKM anda yang berupa file PDF (ukuran file maks 5MB).",
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
                ],
              ),
            ),
          ),
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
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {}); //refresh
                      }

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
                      "Tambah Laporan Keuangan",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
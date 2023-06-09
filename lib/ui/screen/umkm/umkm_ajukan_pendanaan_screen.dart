import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
  String _penghasilan = "";
  String _deskripsi = "";
  String _akad = "";
  File? fileLaporan;
  List<File>? fileImages;

  String? selectedSectorValue, selectedPlafondValue, selectedTenorValue, selectedImbahValue, selectedAngsuranValue;
  String? selectedSectorValueOut, selectedPlafondValueOut, selectedTenorValueOut, selectedImbahValueOut, selectedAngsuranValueOut;

  var error = 'Mohon pilih No. rekening tujuan anda!';


  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
    );

    if (result != null) {
      setState(() {
        textEditingFilePickerController.text = result.files.single.name;
        fileLaporan = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
    }
  }

  void _pickMultipleImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: true
    );

    if (result != null) {
      textEditingImagePickerController.text = result.files.single.name;
      fileImages = result.paths.map((path) => File(path!)).toList();

      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
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
        value: "sektor 1",
        child: Text("Sektor 1"),
      ),
      const DropdownMenuItem<String>(
        value: "sektor 2",
        child: Text("Sektor 2"),
      ),
      const DropdownMenuItem<String>(
        value: "sektor 3",
        child: Text("Sektor 3"),
      )
    ];


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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Masukan Informasi UMKM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // Pekerjaan
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff146C94)),
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
                        child:  DecoratedBox(
                          decoration: BoxDecoration(
                            color:Colors.white,
                            border: Border.all(color: const Color(0xff666666), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              hint: const Text("Sektor"),
                              items: sectorItems,
                              value: selectedSectorValue,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) {
                                    selectedSectorValue = value;
                                  }
                                });
                              },
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff146C94)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Penghasilan Perbulan',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                          controller: textEditingPenghasilanController,
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
                              borderSide: BorderSide(color: Color(0xff146C94)),
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
                          controller: textEditingDeskripsiController,
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
                      const Text("Tambahkan foto UMKM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Row (
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff146C94)),
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
                      const Text("Masukan Informasi Pendanaan",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // Plafond
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child:  DecoratedBox(
                          decoration: BoxDecoration(
                            color:Colors.white,
                            border: Border.all(color: const Color(0xff666666), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              hint: const Text("Plafond"),
                              items: sectorItems,
                              value: selectedPlafondValue,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) {
                                    selectedPlafondValue = value;
                                  }
                                });
                              },
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                        child:  DecoratedBox(
                          decoration: BoxDecoration(
                            color:Colors.white,
                            border: Border.all(color: const Color(0xff666666), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              hint: const Text("Tenor Pendanaan (Minggu)"),
                              items: sectorItems,
                              value: selectedTenorValue,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) {
                                    selectedTenorValue = value;
                                  }
                                });
                              },
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                        child:  DecoratedBox(
                          decoration: BoxDecoration(
                            color:Colors.white,
                            border: Border.all(color: const Color(0xff666666), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              hint: const Text("Imbah Hasil"),
                              items: sectorItems,
                              value: selectedImbahValue,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) {
                                    selectedImbahValue = value;
                                  }
                                });
                              },
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                        child:  DecoratedBox(
                          decoration: BoxDecoration(
                            color:Colors.white,
                            border: Border.all(color: const Color(0xff666666), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              hint: const Text("Jenis Angsuran"),
                              items: sectorItems,
                              value: selectedAngsuranValue,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) {
                                    selectedAngsuranValue = value;
                                  }
                                });
                              },
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                              borderSide: BorderSide(color: Color(0xff146C94)),
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
                      const Text("Tambahkan Laporan Keuangan UMKM anda yang berupa file PDF (ukuran file maks 5MB)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // Akad
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Row (
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff146C94)),
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

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed:  ()  {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _pekerjaan = textEditingPekerjaanController.text;
                          _penghasilan = textEditingPenghasilanController.text;
                          _deskripsi = textEditingDeskripsiController.text;
                          _akad = textEditingAkadController.text;
                        }); //refresh
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
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
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
      ),
    );
  }
}
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class VerifikasiAkun extends StatefulWidget {
  const VerifikasiAkun({super.key, required this.title});

  final String title;

  @override
  _UmkmVerifikasiAkunState createState() => _UmkmVerifikasiAkunState();
}

class _UmkmVerifikasiAkunState extends State<VerifikasiAkun> {
  final _formKey = GlobalKey<FormState>();

  final textEditingNamaController = TextEditingController();
  final textEditingNikController = TextEditingController();
  final textEditingAlamatController = TextEditingController();
  final textEditingTanggalController = TextEditingController();
  final textEditingFilePickerController = TextEditingController();
  DateTime date = DateTime.now();

  String _nama = "";
  String _nik = "";
  String _alamat = "";

  String? selectedGenderValue;
  String? selectedGenderValueOut;

  var error = 'Mohon pilih No. rekening tujuan anda!';
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image != null) {
        final imageTemp = File(image.path);
        textEditingFilePickerController.text = image.name;
        setState(() => this.image = imageTemp);
      } else {
        print("No image is selected.");
      }
    } catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickDatePicker(BuildContext context) async {
    final newDatePicker = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 123),
        lastDate: DateTime(DateTime.now().year + 1),
        initialDate: date,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints:
                  const BoxConstraints(maxWidth: 400.0, maxHeight: 520.0),
                  child: child,
                ),
              )
            ],
          );
        });

    if (newDatePicker == null) return;

    setState(() {
      //
      String rawDate = newDatePicker.toString();
      var explode = rawDate.split(" ");
      String tgl = convertDateFromString(explode[0]).toString();
      textEditingTanggalController.text = tgl;
    });
  }

  convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    return DateFormat("dd/MM/yyyy").format(date);
  }

  @override
  void dispose() {
    textEditingNamaController.dispose();
    textEditingNikController.dispose();
    textEditingAlamatController.dispose();
    textEditingTanggalController.dispose();
    textEditingFilePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> genderItems = [
      const DropdownMenuItem<String>(
        value: "Laki-Laki",
        child: Text("Laki-Laki"),
      ),
      const DropdownMenuItem<String>(
        value: "Perempuan",
        child: Text("Perempuan"),
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Masukan foto KTP (Pastikan foto yang anda unggah terlihat jelas, tidak buram)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 10),
                      image != null ? Image.file(image!) : Container(
                        padding: const EdgeInsets.all(16.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: const Color(0xff146C94)),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text('No image selected'),
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
                      const Text("Masukan informasi data diri anda sesuai pada KTP",
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
                            hintText: 'Nama',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama harus diisi!';
                            }
                            return null;
                          },
                          controller: textEditingNamaController,
                        ),
                      ),
                      // NIK
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
                            hintText: 'NIK',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                          controller: textEditingNikController,
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
                                  hintText: 'Tanggal Lahir',
                                  hintStyle: TextStyle(
                                    color: Color(0xff4A4A4A),
                                    fontSize: 14,
                                  ),
                                ),
                                controller: textEditingTanggalController,
                              ),
                            ),

                            const SizedBox(width: 5),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff19A7CE),
                                    minimumSize: const Size(70, 48),
                                    maximumSize: const Size(70, 48)),
                                onPressed: () => pickDatePicker(context),
                                child: const FaIcon(
                                  FontAwesomeIcons.calendarDay,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                            ),
                          ],
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
                              hint: const Text("Jenis Kelamin"),
                              items: genderItems,
                              value: selectedGenderValue,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) {
                                    selectedGenderValue = value;
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
                      // Alamat
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: TextFormField(
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
                            hintText: 'Alamat',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                          controller: textEditingAlamatController,
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
            child: Column (
              children: [
                ElevatedButton(
                  onPressed:  ()  {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _nama = textEditingNamaController.text;
                        _nik = textEditingNikController.text;
                        _alamat = textEditingAlamatController.text;
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
                    "Verifikasi",
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
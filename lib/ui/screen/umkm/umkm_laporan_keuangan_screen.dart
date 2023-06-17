import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/umkm_model.dart';
import 'package:investkuy/ui/cubit/add_laporan_cubit.dart';
import 'package:investkuy/ui/screen/investor/visitor_pdf_screen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UmkmLaporanKeuangan extends StatefulWidget {
  const UmkmLaporanKeuangan({super.key, required this.title, required this.id});

  final String title;
  final int id;

  @override
  _UmkmLaporanKeuanganState createState() => _UmkmLaporanKeuanganState();
}

class _UmkmLaporanKeuanganState extends State<UmkmLaporanKeuangan> {
  final _formKey = GlobalKey<FormState>();

  final textEditingFilePickerController = TextEditingController();

  String? fileLaporan;

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

  Future refresh() async {
    setState(() {
      textEditingFilePickerController.text = "";
      BlocProvider.of<AddLaporanCubit>(context).getAllLaporan(widget.id);
    });
  }

  @override
  void dispose() {
    textEditingFilePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddLaporanCubit>(context).getAllLaporan(widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff19A7CE),
      ),
      body: BlocBuilder<AddLaporanCubit, DataState>(builder: (context, state) {
        List<LaporanModel> listLaporan = [];

        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SuccessState) {
          if (state is SuccessState<List<LaporanModel>>) {
            listLaporan = state.data;
          } else if (state is SuccessState<String>) {
            refresh();
            // Navigator.pop(context);
          }
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Daftar Laporan Keuangan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listLaporan.length,
                    itemBuilder: (context, index) {
                      final pdfFile = listLaporan[index];

                      return ListTile(
                        leading: const Icon(Icons.picture_as_pdf),
                        title: Text('Laporan Keuangan ke - ${index + 1}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisitorPdfScreen(url: pdfFile.laporanUrl),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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

                    context
                        .read<AddLaporanCubit>()
                        .addLaporan(fileLaporan!, widget.id);
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
                        borderRadius: BorderRadius.circular(10),),),
                child: const Text(
                  "Tambah Laporan Keuangan",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

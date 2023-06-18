import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/ui/cubit/pdf_cubit.dart';
import 'package:path/path.dart';

class VisitorPdfScreen extends StatefulWidget {
  const VisitorPdfScreen({super.key, required this.url});

  final String url;

  @override
  State<VisitorPdfScreen> createState() => _VisitorPdfScreenState();
}

class _VisitorPdfScreenState extends State<VisitorPdfScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PdfCubit>(context).getPdf(widget.url);
    return BlocBuilder<PdfCubit, DataState>(
      builder: (context, state) {
        String name = "";
        String? path;
        if (state is LoadingState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('PDF Reader'),
              backgroundColor: const Color(0xff19A7CE),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SuccessState) {
          name = basename(state.data.path);
          path = state.data.path;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(name),
            backgroundColor: const Color(0xff19A7CE),
          ),
          body: PDFView(
            filePath: path,
            pageSnap: false,
            pageFling: false,
          ),
        );
      },
    );
  }
}

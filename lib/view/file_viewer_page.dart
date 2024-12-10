import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:io';

class DocumentPage extends StatefulWidget {
  final String apartmentName;

  DocumentPage({Key? key, required this.apartmentName}) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  String localFilePath = '';

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    // Carregar os bytes do PDF
    final ByteData bytes = await rootBundle.load('lib/mockdata/file.pdf');
    
    // Obter o diretório de documentos do dispositivo
    final String path = 'lib/mockdata/file.pdf';
    
    // Salvar o PDF no diretório de documentos
    final File file = File(path);
    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

    setState(() {
      localFilePath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documento - ${widget.apartmentName}'),
      ),
      body: localFilePath.isNotEmpty
          ? PDFView(
              filePath: localFilePath,
            )
          : Center(child: CircularProgressIndicator()), // Mostra o loading enquanto o PDF carrega
    );
  }
}

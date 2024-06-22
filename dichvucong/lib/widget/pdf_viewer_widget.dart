import 'dart:io';

import 'package:dichvucong/methods/button_method.dart';
import 'package:dichvucong/methods/navigate_before_method.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SfPdfViewer.network(
      //     'https://dowaco.vn/luutru/DonXinXacNhanTamTru.pdf')
      body: Stack(
        children: [
          SfPdfViewer.network(
              'https://dowaco.vn/luutru/DonXinXacNhanTamTru.pdf'),
          // Center(
          //   child: Text("Hello"),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 60, bottom: 25),
                color: Colors.black,
                child: Row(
                  children: [
                    navigateBeforeMethod(context, color: Colors.white),
                    const Text(
                      "Đơn đăng ký.pdf",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonMethod(
                        displayText: "Hủy",
                        width: 150,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", ModalRoute.withName('/'));
                        },
                        backgroundColor: Colors.grey[700],
                        foregroundColor: Colors.white),
                    buttonMethod(
                        displayText: "Tải xuống",
                        width: 150,
                        onPressed: () {
                          _downloadPDF(context,
                              "https://dowaco.vn/luutru/DonXinXacNhanTamTru.pdf");
                        },
                        backgroundColor: Colors.red[900],
                        foregroundColor: Colors.white)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _downloadPDF(BuildContext context, String url) async {
    // Request storage permissions
    // if (await Permission.storage.request().isGranted) {
    // Get the external storage directory

    final dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);

    //Directory? downloadsDirectory = await getDownloadsDirectory();
    // Define the file path
    final filePath = "${dir}/downloaded_file.pdf";

    try {
      // Download the file
      await Dio().download(url, filePath);
      // Notify the user
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Downloaded to $filePath')));
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('denied')));
    // }
  }
}

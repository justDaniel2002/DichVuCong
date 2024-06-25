import 'dart:ffi';
import 'dart:io';

import 'package:dichvucong/api/file_api.dart';
import 'package:dichvucong/api/pdf_api.dart';
import 'package:dichvucong/api/scan_api.dart';
import 'package:dichvucong/models/data_model.dart';
import 'package:dichvucong/widget/pdf_viewer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScanFillPage extends StatefulWidget {
  const ScanFillPage({super.key, required this.service});
  final String service;

  @override
  State<ScanFillPage> createState() => _ScanFillPageState();
}

class _ScanFillPageState extends State<ScanFillPage> {
  bool loading = false;
  DateTime? updateTime;
  DataModel? register;
  DataModel? owner;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    widget.service,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 7),
              child: const Text(
                "Hướng dẫn thực hiện",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 35),
              child: const Text(
                "Để thực hiện đăng ký thay đổi thông tin cư trú, công dân cần thực hiện quét tất cả các mục theo danh sách thông tin dưới đây.",
                style: TextStyle(letterSpacing: 1),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tờ khai của bạn",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PdfViewerPage(
                                  link:
                                      'https://dowaco.vn/luutru/DonXinXacNhanTamTru.pdf',
                                  type: "network")));
                    },
                    child: Text(
                      "Xem tờ khai mẫu",
                      style: TextStyle(
                          color: Colors.red[900], fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          size: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 2),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 250,
                                  child: Text(
                                    "Tờ khai ${widget.service}.pdf",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        overflow: TextOverflow.ellipsis),
                                  )),
                              Text(
                                updateTime == null
                                    ? "Chưa được cập nhập"
                                    : updateTime.toString(),
                                style: const TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: handleSaveFile,
                    child: Icon(
                      Icons.upload_file,
                      color: Colors.red[900],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: const Text(
                "Danh sách thông tin",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            infoWidget(
                model: register,
                info: "người đăng ký",
                paperType: "CCCD người đăng ký"),
            infoWidget(
                model: owner, info: "chủ hộ", paperType: "CCCD người chủ hộ")
          ])),
    ));
  }

  Container infoWidget(
      {required DataModel? model,
      required String info,
      required String paperType}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1. Thông tin $info",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "Loại giấy tờ: $paperType",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => handleScan(info),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const SizedBox(
                              width: 50,
                              child: Image(
                                  image: AssetImage("assets/scanPng.png")),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model == null
                            ? "Chưa điền thông tin"
                            : "Hoàn tất thông tin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: model == null
                                ? Colors.black45
                                : Colors.cyan[200]),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Icon(
                              Icons.edit,
                              color: Colors.red[900],
                              size: 17,
                            ),
                          ),
                          Text("Chỉnh sửa",
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Colors.red.shade900,
                                      offset: const Offset(0, -3))
                                ],
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red[200],
                                decorationThickness: 3,
                                fontWeight: FontWeight.bold,
                                color: Colors.transparent,
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleSaveFile() {
    if (register == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thiếu thông tin người đăng ký')));
      return;
    }

    if (owner == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thiếu thông tin chủ hộ')));
      return;
    }

    PdfApi.generatePDF(register as DataModel, owner as DataModel,
            name: "Tờ khai ${widget.service}.pdf")
        .then((file) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PdfViewerPage(link: file, type: "file")));
    });
  }

  void handleScan(String type) {
    FileApi.pickimageFromCamera().then((file) {
      if (file == null) {
        return;
      }
      if (file is File) {
        ScanApi.uploadImage(file.path).then((model) {
          if (model == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('hãy thử lại')));
            return;
          }
          setState(() {
            type == "người đăng ký" ? register = model : owner = model;
          });
        });
      }
    });
  }
}

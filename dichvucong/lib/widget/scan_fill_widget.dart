import 'package:flutter/material.dart';

class ScanFillPage extends StatefulWidget {
  const ScanFillPage({super.key, required this.service});
  final String service;
  final String pathName = "";
  @override
  State<ScanFillPage> createState() => _ScanFillPageState();
}

class _ScanFillPageState extends State<ScanFillPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                child: Text("Hướng dẫn thực hiện"),
              ),
              Container(
                child: Text(
                    "Để thực hiện đăng ký thay đổi thông tin cư trú, công dân cần thực hiện quét tất cả các mục theo danh sách thông tin dưới đây."),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tờ khai của bạn"),
                    Text("Xem tờ khai mẫu"),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf),
                    Text(widget.pathName),
                    Icon(Icons.upload_file)
                  ],
                ),
              )
            ])));
  }
}

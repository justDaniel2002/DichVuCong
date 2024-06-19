import 'package:dichvucong/methods/button_method.dart';
import 'package:dichvucong/methods/text_grey_method.dart';
import 'package:flutter/material.dart';

class ScanPage3 extends StatefulWidget {
  const ScanPage3({super.key, required this.service});

  final String service;
  @override
  State<ScanPage3> createState() => _ScanPageState3();
}

class _ScanPageState3 extends State<ScanPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                color: Colors.grey[100],
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: const Image(
                                    image: AssetImage(
                                        "assets/successBanner.png"))),
                            textGreyMethod(text: "Hoàn tất đăng ký"),
                            textGreyMethod(
                                text:
                                    "Bạn đã hoàn tất đăng ký tạm trú tạm vắng"),
                            buttonMethod(
                                displayText: "Xem trước tài liệu",
                                onPressed: () {}),
                            buttonMethod(
                                displayText: "Về trang chủ",
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/", ModalRoute.withName('/'));
                                })
                          ],
                        ),
                      )
                    ]))));
  }
}

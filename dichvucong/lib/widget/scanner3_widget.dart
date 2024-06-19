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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 100),
                                  child: const Image(
                                      image: AssetImage(
                                          "assets/successBanner.png")),
                                )),
                            textGreyMethod(text: "Hoàn tất đăng ký"),
                            textGreyMethod(
                                text:
                                    "Bạn đã hoàn tất đăng ký tạm trú tạm vắng"),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: buttonMethod(
                                  backgroundColor: Colors.red[900],
                                  displayText: "Xem trước tài liệu",
                                  onPressed: () {}),
                            ),
                            buttonMethod(
                                foregroundColor: Colors.red[900],
                                backgroundColor: Colors.white,
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

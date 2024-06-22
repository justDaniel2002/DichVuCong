import 'package:dichvucong/methods/button_method.dart';
import 'package:dichvucong/methods/navigate_before_method.dart';
import 'package:dichvucong/methods/text_field_method.dart';
import 'package:dichvucong/models/data_model.dart';
import 'package:dichvucong/widget/scanner3_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScanPage2 extends StatefulWidget {
  const ScanPage2({super.key, required this.service, required this.dataModel});

  final String service;

  final DataModel dataModel;

  @override
  State<ScanPage2> createState() => _ScanPageState2();
}

class _ScanPageState2 extends State<ScanPage2> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> keyPair = {
      "Họ và tên": widget.dataModel.name,
      "Ngày sinh": widget.dataModel.dob,
      "CCCD": widget.dataModel.id,
      "Địa chỉ thường chú": widget.dataModel.address
    };

    List<String> keys = [
      "Họ và tên",
      "Ngày sinh",
      "CCCD",
      "Địa chỉ thường chú"
    ];

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navigateBeforeMethod(context),
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
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Bước 2",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Hãy kiểm tra các trường thông tin đã được đọc từ ảnh tài liệu của bạn và sửa lại nếu có thông tin bị thiếu hay sai sót",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: keys
                        .map((key) => Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(key)),
                                  textFieldMethod(
                                    readOnly: true,
                                    text: keyPair[key],
                                    decoration: InputDecoration(
                                        labelText: key,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                        border: const OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(100),
                                                    right:
                                                        Radius.circular(100)))),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  child: buttonMethod(
                      displayText: "Tiếp tục",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanPage3(
                                      service: widget.service,
                                      model: widget.dataModel,
                                    )));
                      }),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}

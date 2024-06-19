import 'dart:convert';
import 'dart:io';
import 'package:dichvucong/methods/button_method.dart';
import 'package:dichvucong/methods/text_grey_method.dart';
import 'package:dichvucong/models/data_model.dart';
import 'package:dichvucong/widget/scanner2_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key, required this.service});

  final String service;
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  File? _selectedImage;

  bool Loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                  "Bước 1",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              textGreyMethod(
                  text:
                      "Để thực hiện đăng ký dịch vụ Đăng ký tạm trú, hãy quét các tài liệu sau:"),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  "-Căn cước công dân",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  "-Giấy phép kinh doanh phòng trọ(Nếu có).",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  "-Giấy cam kết cho thuê trọ (Nếu là người thuê).",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                alignment: Alignment.center,
                child: const Image(image: AssetImage("assets/scanBanner.png")),
              ),
            ],
          ),
        ),
        buttonMethod(
            backgroundColor: Colors.red[900],
            displayText: "${Loading ? "Chờ xử lý..." : "Bắt đầu quét"}",
            onPressed: _pickimageFromCamera)
      ]),
    ));
  }

  Future _pickimageFromGalery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    _selectedImage = File(returnImage!.path);
  }

  Future _pickimageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    print("returnImage");
    print(returnImage);
    _selectedImage = File(returnImage!.path);
    uploadImage(returnImage!.path).then((value) {
      setState(() {
        Loading = false;
      });
    }).catchError((error) {
      print(error);
      print("fetch faild");
      setState(() {
        Loading = false;
      });
    });
  }

  Future<void> uploadImage(String path) async {
    var url = Uri.parse('https://api.fpt.ai/vision/idr/vnm');
    var apiKey = 'cIIkAS92v2MzYEyyv5i75hK3Ii1ZfaUZ';
    var file = File(path); // Replace with actual path to your image file

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add headers
    request.headers['api-key'] = apiKey;

    // Add file to multipart form data
    request.files.add(await http.MultipartFile.fromPath('image', file.path));

    setState(() {
      Loading = true;
    });
    // Send request
    var response = await request.send();

    // Read response stream into a string
    var responseString = await response.stream.bytesToString();

    // Print response body
    print('Response body:');
    print(responseString);

    // Check the response
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      Map<String, dynamic> jsonMap = jsonDecode(responseString);
      List<dynamic> dataList = jsonMap['data'];
      Map<String, dynamic> dataItem = dataList.first;

      // Create a DataModel instance using the fromJson factory constructor
      DataModel dataModel = DataModel.fromJson(dataItem);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScanPage2(
                    service: widget.service,
                    dataModel: dataModel,
                  )));
    } else {
      print('Image upload failed with status ${response.statusCode}');
    }
  }
}

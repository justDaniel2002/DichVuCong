import 'dart:ffi';
import 'dart:io';

import 'package:dichvucong/api/file_api.dart';
import 'package:dichvucong/api/pdf_api.dart';
import 'package:dichvucong/api/scan_api.dart';
import 'package:dichvucong/methods/text_field_method.dart';
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
  List<DataModel> others = [];
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
                  Flexible(
                    flex: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          size: 50,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 4 / 7,
                          padding: const EdgeInsets.only(top: 2),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tờ khai ${widget.service}.pdf",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    overflow: TextOverflow.ellipsis),
                              ),
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
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: handleSaveFile,
                      child: Icon(
                        Icons.upload_file,
                        color: Colors.red[900],
                      ),
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
                model: owner, info: "chủ hộ", paperType: "CCCD người chủ hộ"),
            infoWidget2(
                other: others,
                info: "thành viên trong hộ",
                paperType: "CCCD thành viên")
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
                          InkWell(
                            onTap: () {
                              info == "người đăng ký"
                                  ? showModalRegister()
                                  : showModalOwner();
                            },
                            child: Text("Chỉnh sửa",
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
                          ),
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

  Container infoWidget2(
      {required List<DataModel> other,
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
                        onTap: () => handleScanOther(),
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
                        other.isEmpty
                            ? "Chưa điền thông tin"
                            : "Hoàn tất thông tin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: other.isEmpty
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
                          InkWell(
                            onTap: () {
                              showModalOther();
                            },
                            child: Text("Chỉnh sửa",
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
                          ),
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

  Container infoWidget3({required DataModel model}) {
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
                            "1. Thông tin ${model?.name ?? "Người mới"}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text(
                            "Loại giấy tờ: CCCD",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => handleScanDetailOther(model),
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
                          InkWell(
                            onTap: () {
                              showModalOtherDetail(model);
                            },
                            child: Text("Chỉnh sửa",
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
                          ),
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
            other: others, name: "Tờ khai ${widget.service}.pdf")
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
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Chờ xử lý')));
        ScanApi.uploadImage(file.path).then((model) {
          if (model == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Hãy thử lại')));
            return;
          }
          setState(() {
            type == "người đăng ký" ? register = model : owner = model;
          });
        });
      }
    });
  }

  void handleScanOther() {
    FileApi.pickimageFromCamera().then((file) {
      if (file == null) {
        return;
      }
      if (file is File) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Chờ xử lý')));
        ScanApi.uploadImage(file.path).then((model) {
          if (model == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Hãy thử lại')));
            return;
          }
          setState(() {
            others.add(model);
          });
        });
      }
    });
  }

  void handleScanDetailOther(DataModel model) {
    FileApi.pickimageFromCamera().then((file) {
      if (file == null) {
        return;
      }
      if (file is File) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Chờ xử lý')));
        ScanApi.uploadImage(file.path).then((model) {
          if (model == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Hãy thử lại')));
            return;
          }
          setState(() {
            model = model;
          });
        });
      }
    });
  }

  void showModalRegister() {
    if (register == null) {
      handleScan("người đăng kí");
      return;
    }

    final PhoneController = TextEditingController();
    final EmailController = TextEditingController();
    final TamTruController = TextEditingController();
    final HienTaiController = TextEditingController();
    final NgheNghiepController = TextEditingController();
    final QuanHeController = TextEditingController();

    PhoneController.addListener(() => register!.phone = PhoneController.text);
    EmailController.addListener(() => register!.email = EmailController.text);
    TamTruController.addListener(
        () => register!.tamtru = TamTruController.text);
    HienTaiController.addListener(
        () => register!.hientai = HienTaiController.text);
    NgheNghiepController.addListener(
        () => register!.job = NgheNghiepController.text);
    QuanHeController.addListener(() => register!.role = QuanHeController.text);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                textFieldContainer("Họ tên", register!.name),
                textFieldContainer("Ngày tháng năm sinh", register!.dob),
                textFieldContainer("Số định danh cá nhân", register!.id),
                textFieldContainerWithController(
                    key: "Số điện thoại",
                    controller: PhoneController,
                    value: register!.phone),
                textFieldContainerWithController(
                    key: "Email",
                    controller: EmailController,
                    value: register!.email),
                textFieldContainer("Nơi thường trú", register!.address),
                textFieldContainerWithController(
                    key: "Nơi tạm trú",
                    controller: TamTruController,
                    value: register!.tamtru),
                textFieldContainerWithController(
                    key: "Nơi ở hiện tại",
                    controller: HienTaiController,
                    value: register!.hientai),
                textFieldContainerWithController(
                    key: "Nghề nghiệp",
                    controller: NgheNghiepController,
                    value: register!.job),
                textFieldContainerWithController(
                    key: "Quan hệ với chủ hộ",
                    controller: QuanHeController,
                    value: register!.role),
              ]),
            ),
          );
        });
  }

  void showModalOwner() {
    if (owner == null) {
      handleScan("chủ hộ");
      return;
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 1 / 2,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    textFieldContainer("Họ tên", owner!.name),
                    textFieldContainer("Số định danh cá nhân", owner!.id),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  void showModalOther() {
    if (others.isEmpty) {
      handleScanOther();
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                    children:
                        others.map((ot) => infoWidget3(model: ot)).toList()),
              ),
            ),
          );
        });
  }

  void showModalOtherDetail(model) {
    final NgheNghiepController = TextEditingController();
    final QuanHeController = TextEditingController();

    NgheNghiepController.addListener(
        () => model.job = NgheNghiepController.text);
    QuanHeController.addListener(() => model.role = QuanHeController.text);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 1 / 2,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    textFieldContainer("Họ tên", model.name),
                    textFieldContainer("Ngày tháng năm sinh", model.dob),
                    textFieldContainer("Số định danh cá nhân", model.id),
                    textFieldContainerWithController(
                        key: "Nghề nghiệp",
                        controller: NgheNghiepController,
                        value: model.job),
                    textFieldContainerWithController(
                        key: "Quan hệ với chủ hộ",
                        controller: QuanHeController,
                        value: model.role),
                  ]),
                ),
              ),
            ),
          );
        });
  }
}

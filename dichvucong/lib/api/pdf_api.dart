import 'dart:io';
import 'dart:ui';

import 'package:dichvucong/models/data_model.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static var robotof;
  static var ttf;

  static Future getFont() async {
    final font =
        await rootBundle.load("fonts/Montserrat-VariableFont_wght.ttf");
    robotof = Font.ttf(font);
    final roboto = await rootBundle.load("fonts/Roboto-Regular.ttf");
    robotof = Font.ttf(roboto);
  }

  Future openFile(File file) async {
    final url = file.path;
    try {
      await OpenFile.open(url);
    } catch (e) {
      print(e);
    }
  }

  static Future<File> generatePDF(DataModel register, DataModel owner,
      {name = "document.pdf", required List<DataModel> other}) async {
    final pdf = Document();
    await getFont();

    pdf.addPage(MultiPage(
        build: (context) => [
              buildTitle(),
              buildBody(register, owner),
              buildTable(other),
              buildFooter(),
            ]));

    return saveDocument(name: name, pdf: pdf);
  }

  static String layNgayThangNamHienTai() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);

    var parts = formattedDate.split('/');
    String ngay = parts[0];
    String thang = parts[1];
    String nam = parts[2];

    return 'ngày $ngay tháng $thang năm $nam';
  }

  static buildFooter() => Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Flexible(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(children: [
                  Text(layNgayThangNamHienTai(),
                      style: TextStyle(font: robotof)),
                  Text("Ý KIẾN CỦA CHỦ HỘ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, font: robotof)),
                  Text("(Ghi rõ nội dung, ký ghi rõ họ tên )",
                      style: TextStyle(font: robotof)),
                ])),
            flex: 1),
        Flexible(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(children: [
                  Text(layNgayThangNamHienTai(),
                      style: TextStyle(font: robotof)),
                  Text(
                      "Ý KIẾN CỦA CHỦ SỞ HỮU HOẶC NGƯỜI ĐẠI DIỆN CHỖ Ở HỢP PHÁP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, font: robotof)),
                  Text("(Ký, ghi rõ họ tên)", style: TextStyle(font: robotof)),
                ])),
            flex: 1),
        Flexible(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(children: [
                  Text(layNgayThangNamHienTai(),
                      style: TextStyle(font: robotof)),
                  Text("Ý KIẾN CỦA CHA, MẸ HOẶC NGƯỜI GIÁM HỘ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, font: robotof)),
                  Text("(Ký, ghi rõ họ tên)", style: TextStyle(font: robotof)),
                ])),
            flex: 1),
        Flexible(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(children: [
                  Text(layNgayThangNamHienTai(),
                      style: TextStyle(font: robotof)),
                  Text("NGƯỜI KÊ KHAI",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, font: robotof)),
                  Text("(Ký, ghi rõ họ tên)", style: TextStyle(font: robotof)),
                ])),
            flex: 1)
      ]));

  static buildBody(DataModel register, DataModel owner) => Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        partBody(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("1. Họ, chữ đệm và tên: ${register.name}",
                style: TextStyle(font: robotof))
          ],
        )),
        partBody(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Flexible(
                  child: Text("2. Ngày, tháng, năm sinh: ${register.dob}",
                      style: TextStyle(font: robotof)),
                  flex: 1),
              Flexible(
                  child: Text("3. Giới tính:.........",
                      style: TextStyle(font: robotof)),
                  flex: 1)
            ])),
        partBody(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Flexible(
                  child: Text("4. Số định danh cá nhân/CMND:",
                      style: TextStyle(font: robotof)),
                  flex: 1),
              Flexible(
                  child: Text(register.id, style: TextStyle(font: robotof)),
                  flex: 1)
            ])),
        partBody(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Flexible(
                  child: Text("5. Số điện thoại liên hệ: ${register.phone}",
                      style: TextStyle(font: robotof)),
                  flex: 1),
              Flexible(
                  child: Text("6. Email: ${register.email}",
                      style: TextStyle(font: robotof)),
                  flex: 1)
            ])),
        partBody(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("7. Nơi thường trú: ${register.address}",
                  style: TextStyle(font: robotof))
            ],
          ),
        ),
        partBody(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("8. Nơi tạm trú: ${register.tamtru}",
                  style: TextStyle(font: robotof))
            ],
          ),
        ),
        partBody(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("9. Nơi ở hiện tại: ${register.hientai}",
                  style: TextStyle(font: robotof))
            ],
          ),
        ),
        partBody(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("10. Nghề nghiệp,  nơi làm việc: ${register.job}",
                  style: TextStyle(font: robotof))
            ],
          ),
        ),
        partBody(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: Text("11. Họ, chữ đệm và tên chủ hộ:${owner.name}",
                    style: TextStyle(font: robotof)),
                flex: 1),
            Flexible(
                child: Text("12. Quan hệ với chủ hộ: ${register.role}",
                    style: TextStyle(font: robotof)),
                flex: 1)
          ]),
        ),
        partBody(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: Text("13. Số định danh cá nhân/CMND của chủ hộ:",
                    style: TextStyle(font: robotof)),
                flex: 1),
            Flexible(
                child: Text(owner.id, style: TextStyle(font: robotof)), flex: 1)
          ]),
        ),
        partBody(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  "14. Nội dung đề nghị(2):.........................................",
                  style: TextStyle(font: robotof))
            ],
          ),
        ),
        partBody(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("15. Những thành viên trong hộ gia đình cùng thay đổi:",
                  style: TextStyle(font: robotof))
            ],
          ),
        ),
      ]));

  static Container partBody({required child}) {
    return Container(margin: const EdgeInsets.only(bottom: 3), child: child);
  }

  static buildTitle() => Column(children: [
        titleMethod(
          title: "CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM",
        ),
        titleMethod(title: "Độc lập – Tự do – Hạnh phúc", bottom: 10),
        titleMethod(
          title: "TỜ KHAI THAY ĐỔI THÔNG TIN CƯ TRÚ",
        ),
        titleMethod(
          title: "Kính gửi:…………………...………",
        )
      ]);

  static Container titleMethod({required String title, double bottom = 5}) {
    return Container(
        margin: EdgeInsets.only(bottom: bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, font: robotof, fontSize: 10))
          ],
        ));
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();

    final dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final file = File('${dir}/${name}');

    await file.writeAsBytes(bytes);

    return file;
  }

  static dynamic buildTable(List<DataModel> other) {
    if (other.isEmpty) return SizedBox();

    final headers = [
      textMethod("TT"),
      textMethod("Họ, chữ đệm và tên"),
      textMethod("Ngày, tháng, năm sinh"),
      textMethod("Giới tính"),
      textMethod("Số định danh cá nhân/CMND"),
      textMethod("Nghề nghiệp, nơi làm việc"),
      textMethod("Quan hệ với  người có thay đổi"),
      textMethod("Quan hệ với chủ hộ")
    ];

    final data = other
        .map((ot) => [
              "",
              textMethod(ot.name),
              textMethod(ot.dob),
              "",
              textMethod(ot.id),
              textMethod(ot.job),
              "",
              textMethod(ot.role)
            ])
        .toList();

    return TableHelper.fromTextArray(data: data, headers: headers);
  }

  static Text textMethod(String text) =>
      Text(text, style: TextStyle(font: robotof));
}

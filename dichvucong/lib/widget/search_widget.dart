import 'package:dichvucong/models/service.dart';
import 'package:dichvucong/widget/scan_fill_widget.dart';
import 'package:dichvucong/widget/scanne_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key}) {
    services.add(Service(
        serviceName: "Cư trú và giấy tờ tùy thân", serviceList: service1));
    services
        .add(Service(serviceName: "Sức khỏe và y tế", serviceList: service2));
    services.add(Service(serviceName: "Việc làm", serviceList: service3));
  }

  final List<String> service1 = [
    "Đăng ký tạm trú",
    "Đăng ký tạm vắng",
    "Đăng ký hộ khẩu",
  ];

  final List<String> service2 = [
    "Chính sách Y tế",
    "Khám chữa bệnh",
  ];

  final List<String> service3 = [
    "Thuế thu nhập cá nhân",
    "Chứng chỉ hành nghề",
  ];

  final List<Service> services = [];

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: double.maxFinite,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    const Text(
                      "Danh sách dịch vụ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: const TextField(
                  decoration: InputDecoration(
                      labelText: "Tên dịch vụ",
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(100),
                              right: Radius.circular(100)))),
                ),
              ),
              ...widget.services.map((serv) => servicesRender(serv, context))
            ],
          ),
        ),
      ),
    );
  }

  Column servicesRender(Service serv, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Text(
            serv.serviceName,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: serv.serviceList
              .map((sv) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScanFillPage(
                                    service: sv,
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Icon(
                                  Icons.search,
                                  size: 20,
                                ),
                              ),
                              Text(
                                sv,
                                style: const TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                          const Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}

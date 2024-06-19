import 'package:dichvucong/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../models/question.dart';
import '../models/service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final List<Service> services = [
    Service(serviceName: "Hành chính"),
    Service(serviceName: "Học tập"),
    Service(serviceName: "Sức khỏe"),
    Service(serviceName: "Tất cả"),
  ];

  final List<Question> questions = [
    Question(content: "Những giấy tờ nào cần chuẩn bị khi đăng ký tạm trú?"),
    Question(content: "Lương NET là gì? Cách tính lương NET sang GROSS??")
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GNav(
          tabs: const [
            GButton(icon: Icons.home),
            GButton(icon: Icons.wallet),
            GButton(icon: Icons.notifications),
            GButton(icon: Icons.person)
          ],
          color: Colors.black54,
          backgroundColor: Colors.white,
          activeColor: const Color.fromARGB(255, 187, 1, 1),
          gap: 8,
          padding: const EdgeInsets.all(16),
          iconSize: 30,
          onTabChange: (index) => {print(index)},
        ),
        body: Stack(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.topCenter,
                color: Colors.red[900],
                height: double.infinity,
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      const Text(
                        "Nguyen Van A",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              margin: const EdgeInsets.only(top: 100),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "Nhóm dịch vụ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.services
                          .map((sv) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Image(
                                        image: AssetImage(
                                            "assets/bannerService.png")),
                                  ),
                                  Text(
                                    sv.serviceName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Image(
                              image: AssetImage("assets/homeBanner.png"))),
                    ),
                    const Text("Câu hỏi thường gặp",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Column(
                      children: widget.questions
                          .map((ques) => Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: Text(ques.content),
                                    ),
                                    const Icon(
                                      Icons.navigate_next,
                                      color: Colors.black54,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

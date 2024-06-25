import 'package:flutter/foundation.dart';

class DataModel {
  String id = "";
  String idProb = "";
  String name = "";
  String nameProb = "";
  String dob = "";
  String dobProb = "";
  String nation = "";
  String nationProb = "";
  String address = "";
  String doe = "";
  String doeProb = "";
  String role = "";
  String phone = "";
  String email = "";
  String tamtru = "";
  String hientai = "";
  String job = "";

  DataModel({
    required this.id,
    required this.idProb,
    required this.name,
    required this.nameProb,
    required this.dob,
    required this.dobProb,
    required this.nation,
    required this.nationProb,
    required this.address,
    required this.doe,
    required this.doeProb,
  });

  factory DataModel.initData() {
    return DataModel(
        id: "",
        idProb: "",
        name: "",
        nameProb: "",
        dob: "",
        dobProb: "",
        nation: "",
        nationProb: "",
        address: "",
        doe: "",
        doeProb: "");
  }

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      idProb: json['id_prob'],
      name: json['name'],
      nameProb: json['name_prob'],
      dob: json['dob'],
      dobProb: json['dob_prob'],
      nation: json['nationality'],
      nationProb: json['nationality_prob'],
      address: json['address'],
      doe: json['doe'],
      doeProb: json['doe_prob'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_prob': idProb,
      'name': name,
      'name_prob': nameProb,
      'dob': dob,
      'dob_prob': dobProb,
      'nation': nation,
      'nation_prob': nationProb,
      'address': address,
      'doe': doe,
      'doe_prob': doeProb,
    };
  }
}

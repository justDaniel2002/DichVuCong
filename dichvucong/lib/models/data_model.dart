class DataModel {
  String id;
  String idProb;
  String name;
  String nameProb;
  String dob;
  String dobProb;
  String nation;
  String nationProb;
  String address;
  String addressProb;
  String placeIssue;
  String placeIssueProb;
  String date;
  String dateProb;
  String doe;
  String doeProb;
  String code;
  String codeProb;
  String type;

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
    required this.addressProb,
    required this.placeIssue,
    required this.placeIssueProb,
    required this.date,
    required this.dateProb,
    required this.doe,
    required this.doeProb,
    required this.code,
    required this.codeProb,
    required this.type,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      idProb: json['id_prob'],
      name: json['name'],
      nameProb: json['name_prob'],
      dob: json['dob'],
      dobProb: json['dob_prob'],
      nation: json['nation'],
      nationProb: json['nation_prob'],
      address: json['address'],
      addressProb: json['address_prob'],
      placeIssue: json['place_issue'],
      placeIssueProb: json['place_issue_prob'],
      date: json['date'],
      dateProb: json['date_prob'],
      doe: json['doe'],
      doeProb: json['doe_prob'],
      code: json['code'],
      codeProb: json['code_prob'],
      type: json['type'],
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
      'address_prob': addressProb,
      'place_issue': placeIssue,
      'place_issue_prob': placeIssueProb,
      'date': date,
      'date_prob': dateProb,
      'doe': doe,
      'doe_prob': doeProb,
      'code': code,
      'code_prob': codeProb,
      'type': type,
    };
  }
}

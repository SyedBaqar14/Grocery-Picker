
import 'dart:convert';

class PackOrderBoxes {

  String boxName;
  int boxId;
  int qty;

  PackOrderBoxes({required this.boxName, required this.boxId, required this.qty});

  factory PackOrderBoxes.fromJson(Map<String, dynamic> jsonData) {
    return PackOrderBoxes(
      boxName: jsonData['boxName'],
      boxId: jsonData['boxId'],
      qty: jsonData['qty'],
    );
  }

  static Map<String, dynamic> toMap(PackOrderBoxes data) => {
    'boxName': data.boxName,
    'boxId': data.boxId,
    'qty': data.qty,
  };

  static String encode(List<PackOrderBoxes> data) => json.encode(
    data
        .map<Map<String, dynamic>>((item) => PackOrderBoxes.toMap(item))
        .toList(),
  );

  static List<PackOrderBoxes> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<PackOrderBoxes>((item) => PackOrderBoxes.fromJson(item))
          .toList();

}
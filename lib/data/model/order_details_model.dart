import 'dart:convert';

class OrdersDetailsModel{
  String? name;
  String? image;
  String? id;
  String? qty;

  OrdersDetailsModel({this.id, this.name, this.image, this.qty});

  factory OrdersDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return OrdersDetailsModel(
      id: jsonData['id'],
      name: jsonData['name'],
      image: jsonData['image'],
      qty: jsonData['qty'],
    );
  }

  static Map<String, dynamic> toMap(OrdersDetailsModel data) => {
    'id': data.id,
    'name': data.name,
    'image': data.image,
    'qty': data.qty,
  };

  OrdersDetailsModel.fromMap(Map<String,dynamic> map){
    id = map['id'];
    name = map['name'];
    image = map['image'];
    qty = map['qty'];
  }

  static String encode(List<OrdersDetailsModel> data) => json.encode(
    data
        .map<Map<String, dynamic>>((item) => OrdersDetailsModel.toMap(item))
        .toList(),
  );

  static List<OrdersDetailsModel> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<OrdersDetailsModel>((item) => OrdersDetailsModel.fromJson(item))
          .toList();
}
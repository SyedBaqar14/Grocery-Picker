
import 'dart:convert';

class OrderProductsModel {

  int orderPackageId;
  int productId;
  String uom;
  int quantity;

  OrderProductsModel(
      {required this.orderPackageId,required this.productId,required this.uom,required this.quantity});

  factory OrderProductsModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderProductsModel(
      orderPackageId: jsonData['orderPackageId'],
      productId: jsonData['productId'],
      uom: jsonData['uom'],
      quantity: jsonData['quantity'],
    );
  }

  static Map<String, dynamic> toMap(OrderProductsModel data) => {
    'orderPackageId': data.orderPackageId,
    'productId': data.productId,
    'uom': data.uom,
    'quantity': data.quantity,
  };

  static String encode(List<OrderProductsModel> data) => json.encode(
    data
        .map<Map<String, dynamic>>((item) => OrderProductsModel.toMap(item))
        .toList(),
  );

  static List<OrderProductsModel> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<OrderProductsModel>((item) => OrderProductsModel.fromJson(item))
          .toList();
}

import 'package:flutter_picker_app/data/model/order_details_model.dart';

class CompletePackage {
  int id;
  Package package;
  List<OrdersDetailsModel> detail;

  CompletePackage({required this.id,required this.package, required this.detail});

  static Map<String, dynamic> toMap(CompletePackage data) => {
    'id': data.id,
    'package': data.package,
    'detail': data.detail,
  };
}

class Package {
  int orderId;
  int packageId;
  String package;
  int packageStatusId;
  int userId;

  Package(
      {required this.orderId,
      required this.packageId,
      required this.package,
      required this.packageStatusId,
      required this.userId});

  static Map<String, dynamic> toMap(Package data) => {
    'order_id': data.orderId,
    'package_id': data.packageId,
    'package': data.package,
    'package_status_id': data.packageStatusId,
    'user_id': data.userId,
  };
}

class OrdersDetails {

  int orderPackageId;
  int productId;
  String uom;
  int quantity;

  OrdersDetails(
      {required this.orderPackageId,required this.productId,required this.uom,required this.quantity});

  static Map<String, dynamic> toMap(OrdersDetails data) => {
    'order_package_id': data.orderPackageId,
    'product_id': data.productId,
    'uom': data.uom,
    'quantity': data.quantity,
  };

}
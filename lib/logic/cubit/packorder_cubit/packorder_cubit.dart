import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/data/model/order_details_model.dart';
import 'package:flutter_picker_app/data/repositories/packorder_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'packorder_state.dart';

class PackOrderCubit extends Cubit<PackOrderState> {
  PackOrderCubit()
      : super(PackOrderState(
            isLoaded: "Loading",
            isLoadedPackOrder: "Loading",
            orderID: 0,
            totalProductsPackOrder: 0,
            orderDetailList: []));

  final repository = PackOrderRepository();

  static List<OrdersDetailsModel> orderDetailList = [];

  setOrderID(int orderID) {
    emit(state.copywith(orderID: orderID));
  }

  getOrder() async {
    orderDetailList = [];
    emit(state.copywith(isLoaded: "Loading"));
    Map<String, dynamic> orderMap = {
      'orderID': state.orderID,
    };
    await repository.getOrder(orderMap).then((value) {
      print(value);
      for (int i = 0;
          i < value.data!['getOrder']['order_products'].length;
          i++) {
        var data = value.data!['getOrder']['order_products'][i];

        var image = data['product']['image'];
        var name = data['name'];
        var qty = data['id'].toString();
        var id = data['quantity'].toString();

        orderDetailList.add(
            OrdersDetailsModel(id: id, name: name, image: image, qty: qty));
      }
      print("orderDetailList at 0: ${orderDetailList[0].name}");
      // print(value);
      emit(state.copywith(
          queryResult: value,
          isLoaded: "complete",
          orderDetailList: orderDetailList,
          totalProductsPackOrder: value.data!['getOrder']
              ['order_products_count']['total_count']));
    });
  }

  addOrderPackage({
    required int packageID,
    required String packageName,
    required int packageStatusID,
  }) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    print(pre.getString('id'));
    int us = int.parse(pre.getString('id')!);

    Map<String, dynamic> addOrderMap = {
      "orderID": state.orderID,
      "packageID": packageID,
      "package": packageName,
      "packageStatusID": packageStatusID,
      "userID": us
    };

    await repository.addOrderPackage(addOrderMap).then((value) {
      print(value);
    });
  }

  filterSearchResults(String query) {
    List<OrdersDetailsModel> dummySearchList = [];

    dummySearchList.addAll(state.orderDetailList);
    print(dummySearchList);

    if (query.isNotEmpty) {
      print("query.isNotEmpty");
      List<OrdersDetailsModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.id!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      List<OrdersDetailsModel> x = [];
      x.addAll(dummyListData);
      emit(state.copywith(orderDetailList: x));

      return;
    } else {
      print("query.isEmpty");
      emit(state.copywith(orderDetailList: orderDetailList));
    }
  }
}

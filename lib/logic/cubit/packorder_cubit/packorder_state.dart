part of 'packorder_cubit.dart';

class PackOrderState {
  QueryResult? queryResult;
  QueryResult? queryResultPackOrder;
  String isLoaded;
  String isLoadedPackOrder;
  int orderID;
  int totalProductsPackOrder;
  List<OrdersDetailsModel> orderDetailList;

  PackOrderState(
      {required this.totalProductsPackOrder, this.queryResult, required this.isLoaded, required this.orderID, required this.orderDetailList, this.queryResultPackOrder, required this.isLoadedPackOrder});

  PackOrderState copywith({
    QueryResult? queryResult,
    int? totalProductsPackOrder,
    String? isLoaded,
    int? orderID,
    QueryResult? queryResultPackOrder,
    String? isLoadedPackOrder,
    List<OrdersDetailsModel>? orderDetailList
  }) {
    return PackOrderState(
        queryResult: queryResult ?? this.queryResult,
        isLoaded: isLoaded ?? this.isLoaded,
        orderID: orderID ?? this.orderID,
    orderDetailList: orderDetailList ?? this.orderDetailList,
    queryResultPackOrder: queryResultPackOrder ?? this.queryResultPackOrder,
    isLoadedPackOrder: isLoadedPackOrder ?? this.isLoadedPackOrder,
    totalProductsPackOrder: totalProductsPackOrder ?? this.totalProductsPackOrder);
  }
}

part of 'delegate_cubit.dart';


class DelegateState {

  QueryResult? queryResultGetUsers;
  QueryResult? queryResultAssignOrder;
  QueryResult? queryResultGetRequest;
  String searchingGetRequest;
  String searchingGetUsers;
  String searchingAssignOrder;
  int? orderID;

  DelegateState({
    this.queryResultGetUsers,
    required this.searchingGetUsers,
    required this.searchingAssignOrder,
    this.queryResultAssignOrder,
    this.orderID,
    this.queryResultGetRequest,
    required this.searchingGetRequest
  });

  DelegateState copywith({
    QueryResult? queryResultGetUsers,
    String? searchingGetUsers,
    QueryResult? queryResultAssignOrder,
    String? searchingAssignOrder,
    int? orderID,
    QueryResult? queryResultGetRequest,
    String? searchingGetRequest
}) {
    return DelegateState(
      queryResultGetUsers: queryResultGetUsers ?? this.queryResultGetUsers,
      searchingGetUsers: searchingGetUsers ?? this.searchingGetUsers,
      searchingAssignOrder: searchingAssignOrder ?? this.searchingAssignOrder,
      queryResultAssignOrder: queryResultAssignOrder ?? this.queryResultAssignOrder,
      orderID: orderID ?? this.orderID,
      queryResultGetRequest: queryResultGetRequest ?? this.queryResultGetRequest,
      searchingGetRequest: searchingGetRequest ?? this.searchingGetRequest
    );
  }
}
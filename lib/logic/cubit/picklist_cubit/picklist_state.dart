part of 'picklist_cubit.dart';

class PickListState {
  QueryResult? queryResultPendinOrder;
  QueryResult? queryResultHoldOrder;
  QueryResult? queryResultFinishOrder;
  QueryResult? queryResultUpdateStatus;

  String searchingPending;
  String searchingHold;
  String searchingFinishOrder;
  String searchingUpdateOrder;

  PickListState(
      {this.queryResultPendinOrder,
      required this.searchingPending,
      this.queryResultUpdateStatus,
      required this.searchingUpdateOrder,
      this.queryResultFinishOrder,
      required this.searchingFinishOrder,
      required this.searchingHold,
      this.queryResultHoldOrder});

  PickListState copywith(
      {QueryResult? queryResultPendinOrder,
      QueryResult? queryResultHoldOrder,
      QueryResult? queryResultFinishOrder,
      QueryResult? queryResultUpdateStatus,
      QueryResult? queryResultGetUsers,
      String? searchingPending,
      String? searchingUpdateOrder,
      String? searchingGetUsers,
      String? searchingFinishOrder,
      String? searchingHold}) {
    return PickListState(
        queryResultPendinOrder:
            queryResultPendinOrder ?? this.queryResultPendinOrder,
        searchingPending: searchingPending ?? this.searchingPending,
        searchingFinishOrder: searchingFinishOrder ?? this.searchingFinishOrder,
        queryResultUpdateStatus:
            queryResultUpdateStatus ?? this.queryResultUpdateStatus,
        searchingUpdateOrder: searchingUpdateOrder ?? this.searchingUpdateOrder,
        searchingHold: searchingHold ?? this.searchingHold,
        queryResultHoldOrder: queryResultHoldOrder ?? this.queryResultHoldOrder,
        queryResultFinishOrder:
            queryResultFinishOrder ?? this.queryResultFinishOrder);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/data/repositories/pick_list_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'picklist_state.dart';

class PickListCubit extends Cubit<PickListState> {
  PickListCubit()
      : super(PickListState(
            searchingPending: "searching",
            searchingUpdateOrder: "searching",
            searchingFinishOrder: "searching",
            searchingHold: "searching"));

  final repository = PickListRepository();

  // getPendingOrders({required int userID, required int orderStatusID}) async {
  //   emit(state.copywith(searchingPending: "searching"));
  //   Map<String, dynamic> orderMap = {
  //     'userId': userID,
  //     'orderStatus': orderStatusID
  //   };
  //   await repository.getPendingOrders(orderMap).then((value) {
  //     // var data = value.data?['listOrdersFilters']['orders'];
  //     print(value);
  //     emit(state.copywith(
  //         queryResultPendinOrder: value, searchingPending: "complete"));
  //   });
  // }

  getOrders({required int userID, required int orderStatusID}) async {
    emit(state.copywith(searchingPending: "searching"));
    Map<String, dynamic> orderMap = {
      'userId': userID,
      'orderStatus': orderStatusID
    };
    await repository.getPendingOrders(orderMap).then((value) {
      // var data = value.data?['listOrdersFilters']['orders'];
      print(value);

      if (orderStatusID == 1) {
        emit(state.copywith(
            queryResultPendinOrder: value, searchingPending: "complete"));
      } else if (orderStatusID == 13) {
        emit(state.copywith(
            queryResultHoldOrder: value, searchingHold: "complete"));
      } else if (orderStatusID == 14) {
        emit(state.copywith(
            queryResultFinishOrder: value, searchingFinishOrder: "complete"));
      }
    });
  }

  updateOrderStatus({required int orderID, required int orderStatus}) async {
    emit(state.copywith(searchingUpdateOrder: "searching"));
    Map<String, dynamic> orderMap = {'id': orderID, 'orderStatus': orderStatus};
    await repository.updateOrderStatus(orderMap).then((value) {
      emit(state.copywith(
          queryResultUpdateStatus: value, searchingUpdateOrder: "complete"));
    });
  }
}

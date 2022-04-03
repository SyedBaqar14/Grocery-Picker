import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/data/repositories/delegate_order_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'delegate_state.dart';

class DelegateCubit extends Cubit<DelegateState> {
  DelegateCubit()
      : super(DelegateState(
            searchingGetUsers: "searching",
            searchingAssignOrder: "searching",
            searchingGetRequest: "searching"));

  final repository = DelegateRepository();

  setOrderID({required int orderID}) {
    emit(state.copywith(orderID: orderID));
  }

  getUsers() async {
    emit(state.copywith(searchingGetUsers: "searching"));
    await repository.getUsers().then((value) {
      print(value);
      emit(state.copywith(
          queryResultGetUsers: value, searchingGetUsers: "complete"));
    });
  }

  getRequest(int userID) async {
    Map<String, dynamic> variables = {'assignUserID': userID};
    emit(state.copywith(searchingGetRequest: "searching"));
    await repository.getRequest(variables).then((value) {
      print(value);
      emit(state.copywith(
          queryResultGetRequest: value, searchingGetRequest: "complete"));
    });
  }

  assignOrder({required int userID}) async {
    emit(state.copywith(searchingAssignOrder: "searching"));
    Map<String, dynamic> orderMap = {
      'orderID': state.orderID,
      'userID': userID
    };
    await repository.assignOrder(orderMap).then((value) {
      print(value);
      emit(state.copywith(
          queryResultAssignOrder: value, searchingAssignOrder: "complete"));
    });
  }
}

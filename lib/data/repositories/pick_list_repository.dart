
import 'package:flutter_picker_app/data/provider/pick_list_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PickListRepository {

  final provider = PickListProvider();

  Future<QueryResult> getPendingOrders(variable) async {

    final result = await provider.getPendingOrder(variable);

    return result;
  }

  Future<QueryResult> updateOrderStatus(variable) async {

    final result = await provider.updateOrderStatus(variable);

    return result;
  }
}
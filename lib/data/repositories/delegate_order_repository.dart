
import 'package:flutter_picker_app/data/provider/delegate_order_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DelegateRepository {

  final provider = DelegateOrderProvider();

  Future<QueryResult> getUsers() async {

    final result = await provider.getUsers();

    return result;
  }

  Future<QueryResult> getRequest(variables) async {

    final result = await provider.getRequest(variables);

    return result;
  }

  Future<QueryResult> assignOrder(variable) async {

    final result = await provider.assignOrder(variable);

    return result;
  }
}
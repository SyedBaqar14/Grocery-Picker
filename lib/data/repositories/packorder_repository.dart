
import 'package:flutter_picker_app/data/provider/packorder_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PackOrderRepository {

  final provider = PackOrderProvider();

  Future<QueryResult> getOrder(variable) async {

    final result = await provider.getOrder(variable);

    return result;
  }

  Future<QueryResult> addOrderPackage(variable) async {

    final result = await provider.addOrderPackage(variable);

    return result;
  }

}
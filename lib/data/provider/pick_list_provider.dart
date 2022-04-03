import 'package:flutter_picker_app/utlis/gql_mutations.dart';
import 'package:flutter_picker_app/utlis/gql_quries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'init_provider.dart';

class PickListProvider {
  final provider = InitProvider();

  Future<QueryResult> getPendingOrder(Map<String, dynamic> variable) async {
    QueryOptions options = QueryOptions(document: gql(GQLQuries.getPendingOrders), variables: variable,fetchPolicy: FetchPolicy.networkOnly);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> updateOrderStatus(Map<String, dynamic> variable) {
    MutationOptions options = MutationOptions(document: gql(GQLMutation.updateStatusOfOrder), variables: variable);

    final result = provider.client.mutate(options);

    return result;
  }

}
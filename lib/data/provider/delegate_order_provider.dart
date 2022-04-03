import 'package:flutter_picker_app/utlis/gql_mutations.dart';
import 'package:flutter_picker_app/utlis/gql_quries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'init_provider.dart';

class DelegateOrderProvider {

  final provider = InitProvider();

  Future<QueryResult> getUsers() async {
    QueryOptions options = QueryOptions(document: gql(GQLQuries.getUsers));

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getRequest(Map<String, dynamic> variables) async {
    QueryOptions options = QueryOptions(document: gql(GQLQuries.getRequest), variables: variables, fetchPolicy: FetchPolicy.networkOnly);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> assignOrder(Map<String, dynamic> variable) {
    MutationOptions options = MutationOptions(document: gql(GQLMutation.assignOrder), variables: variable);

    final result = provider.client.mutate(options);

    return result;
  }
}

import 'package:flutter_picker_app/data/provider/init_provider.dart';
import 'package:flutter_picker_app/utlis/gql_mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PackOrderProvider {

  final provider = InitProvider();

  Future<QueryResult> getOrder(Map<String, dynamic> variable) {
  MutationOptions options = MutationOptions(document: gql(GQLMutation.getOrder), variables: variable);

    final result = provider.client.mutate(options);

    return result;
  }


  Future<QueryResult> addOrderPackage(Map<String, dynamic> variable) {
    MutationOptions options = MutationOptions(document: gql(GQLMutation.addOrderPackage), variables: variable);

    final result = provider.client.mutate(options);

    return result;
  }
}
import 'package:flutter_picker_app/data/provider/init_provider.dart';
import 'package:flutter_picker_app/utlis/gql_mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthProvider{
  final initProvider = InitProvider();

  Future<QueryResult> registerPhone(
      {required Map<String, dynamic> variables}) async {
    MutationOptions options = MutationOptions(
        document: gql(GQLMutation.generateOTPQuery), variables: variables);
    final result = await initProvider.client.mutate(options);
    return result;
  }

  Future<QueryResult> verifyOtp(Map<String, dynamic> variables) async {
    MutationOptions options = MutationOptions(
        document: gql(GQLMutation.verifyOtpQuery), variables: variables);
    final result = await initProvider.client.mutate(options);
    return result;
  }

}
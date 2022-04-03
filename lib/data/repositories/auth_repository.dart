import 'package:flutter_picker_app/data/provider/auth_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthRepository{
  final provider = AuthProvider();

  Future<QueryResult> regitserPhone(Map<String, dynamic> variables) async {
    final result = provider.registerPhone(variables: variables);
    return result;
  }

  Future<QueryResult> verifyOtp(Map<String, dynamic> variables) async {
    final result = provider.verifyOtp(variables);
    return result;
  }
}
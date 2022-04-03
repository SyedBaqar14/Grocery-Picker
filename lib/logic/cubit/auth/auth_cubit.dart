import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_app/data/repositories/auth_repository.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(
    otpErro: "",
    phoneNum: "",
  ));
  final repository = AuthRepository();

  String phoneNumberVal = '';
  String otpError = '';
  String userId = '';

  String get getuserID => state.userId!;

  phoneNumber(String phone) {
    emit(state.copywith(phoneNu: phone));
    phoneNumberVal = phone;
  }

  otp(String otp) {
    emit(
      state.copywith(
        otpp: otp,
      ),
    );
  }

  String get phoneNumberr => state.phoneNum!;

  registerPhone() {
    repository.regitserPhone({
      'source': state.phoneNum,
      'source_type': 1,
      'user_type': 'user',
    }).then((result) {
      print(result);
      emit(state.copywith(numberResultt: result));
    });
  }
  // +923323394163

  verifyOtp(BuildContext context) {
    repository.verifyOtp({
      'source': phoneNumberVal,
      'source_type': 1,
      'OTP': int.parse(state.otp!),
    }).then((result) {
      print(result.data);

      // print(result.data?['verifyOTP']['firstname'] != null && result.data?['verifyOTP']['firstname'] != '' ? "USer Profile Exist" : "Not Exist");
      if (result.data?['verifyUserOTP']['is_verified_mobile'] == 1) {
        // valid otp
        var us = result.data?['verifyUserOTP']['id'].toString();
        userId = us!;
        emit(state.copywith(otpResultt: result, otpError: ""));

        Future.delayed(const Duration(seconds: 1), () => saveDataInShared());
        Navigator.pushNamedAndRemoveUntil(
            context, bottomnav, (route) => false);
      } else {
        // invalid Otp
        emit(state.copywith(otpError: "Invalid OTP"));
      }
    });
  }

  saveDataInShared() async {
    print(userId);
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('id', userId);
    pre.setString('phone', state.phoneNum!);
    getSharedData();
  }

  getSharedData() async {
    print("called");
    SharedPreferences pre = await SharedPreferences.getInstance();
    print(pre.getString('id'));
    var us = pre.getString('id');
    userId = us!;
    print("user id $userId");
    var phone = pre.getString('phone');
    emit(state.copywith(
        userid: userId, phoneNu: phone));
  }

  logout() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.clear();
  }

}

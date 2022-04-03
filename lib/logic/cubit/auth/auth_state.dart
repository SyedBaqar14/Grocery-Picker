part of 'auth_cubit.dart';


class  AuthState {
  final String? phoneNum;
  final String? otp;
  final QueryResult? numberResult;
  final QueryResult? otpResult;
  final String? otpErro;
  final String? userId;

  AuthState({this.phoneNum,
    this.otp,
    this.numberResult,
    this.otpResult,
    this.otpErro,
    this.userId,
  });

  AuthState copywith({
    final String? phoneNu,
    final String? otpp,
    final QueryResult? numberResultt,
    final QueryResult? otpResultt,
    final String? otpError,
    final String? userid,
  }) {
    return AuthState(
      phoneNum: phoneNu ?? phoneNum,
      otp: otpp ?? otp,
      numberResult: numberResultt ?? numberResult,
      otpResult: otpResultt ?? numberResult,
      otpErro: otpError ?? otpErro,
      userId: userid ?? userId,
    );
  }

}

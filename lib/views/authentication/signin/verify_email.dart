import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/components/asset_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/src/provider.dart';

import '../../../constants.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  double height = 50;
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit,AuthState>(
      builder: (context,state) {
        return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: Color(0xffFE8086),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40,),
                          const Center(
                            child: AssetProvider(
                              asset: AssetConfig.kOTP,
                              height: 250,
                              width: 250,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "OTP Vefification",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xffFE8086),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Enter OTP sent to your mobile",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              PinCodeTextField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please Enter Code";
                                  } else if (val.length < 4) {
                                    return "Enter Correct OTP";
                                  }
                                },
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                appContext: context,
                                length: 4,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  inactiveColor: kTextFieldFilledColor,
                                  inactiveFillColor: kTextFieldFilledColor,
                                  selectedColor: kTextFieldFilledColor,
                                  selectedFillColor: kTextFieldFilledColor,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 50,
                                  fieldWidth: 50,
                                  activeFillColor: Colors.white,
                                ),
                                animationDuration:
                                const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                onCompleted: (v) {
                                  // pro.verifyEmail(context);
                                },
                                onChanged: (value) {
                                  context.read<AuthCubit>().otp(value);
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                              ),
                              Text(
                                state.otpErro!,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const Text(
                                "",
                                style: TextStyle(color: Colors.red),
                              ),
                              sizeBox30(),
                              height == 0
                                  ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kUniversalColor),
                                ),
                              )
                                  : Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isPressed = true;
                                      Future.delayed(
                                          const Duration(milliseconds: 800),
                                              () {
                                            setState(() {
                                              height = 0;
                                            });
                                          });
                                    });
                                    Future.delayed(const Duration(seconds: 3),
                                            () {
                                          setState(() {
                                            height = 50;
                                            isPressed = false;
                                          });
                                        });
                                    context
                                        .read<AuthCubit>()
                                        .verifyOtp(context);
                                  },
                                  child: AnimatedContainer(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: kUniversalColor,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    curve: Curves.fastOutSlowIn,
                                    duration: const Duration(milliseconds: 800),
                                    width: isPressed ? 60 : 500,
                                    padding: const EdgeInsets.all(10),
                                    // width: 60,
                                    child: Center(
                                      child: Text(
                                        "Verify",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("if you didn't received an OTP!", style: TextStyle(
                                    fontSize: 16,
                                    color: kUniversalColor,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  TextButton(
                                    onPressed: () {
                                      if (key.currentState!.validate()) {

                                      }
                                    },
                                    child: const Text("Resend", style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
      }
    );
  }
}

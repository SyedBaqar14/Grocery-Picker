import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/authentication/components/skip_btn.dart';
import 'package:flutter_picker_app/views/components/asset_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit,AuthState>(
      builder: (context,state) {
        return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40,),
                        const Center(
                          child: AssetProvider(
                            asset: AssetConfig.kLogin,
                            height: 250,
                            width: 250,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const[
                             Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xffFE8086),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10,),
                             Text(
                              "with your email or phone number",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: key,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Phone is required";
                                  }
                                },
                                inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                                keyboardType: TextInputType.phone,
                                onChanged: (val) => context
                                    .read<AuthCubit>()
                                    .phoneNumber(val),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xffE4F9E8),
                                      width: 2,
                                    ),
                                  ),
                                  focusColor: const Color(0xffE4F9E8),
                                  // border: InputBorder.none,
                                  fillColor: const Color(0xffE4F9E8),
                                  filled: true,
                                  hintText: "Enter your Phone Number",
                                  prefixIcon: const Icon(
                                    Icons.phone_android,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minWidth: double.infinity,
                                color: const Color(0xffFE8086),
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    // context
                                    //     .read<AuthenticationCubit>()
                                    //     .registerPhone();
                                    context
                                        .read<AuthCubit>()
                                        .registerPhone();
                                    Navigator.pushNamed(context, verifyEmail);
                                  }
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        /*
                        Login with Google
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.black,
                            ),
                            const Text("Or login with"),
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png",
                                height: 20,
                              ),
                              const Text("Google"),
                              Container(
                                width: 20,
                              ),
                            ],
                          ),
                        )

                         */
                      ],
                    ),
                  ),
                ),
              ),
            );
      }
    );
  }
}

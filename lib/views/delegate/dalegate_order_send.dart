import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/delegate/delegate_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/picklist_cubit/picklist_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class DelegateOrderSendRequest extends StatefulWidget {
  const DelegateOrderSendRequest({Key? key}) : super(key: key);

  @override
  _DelegateOrderSendRequestState createState() =>
      _DelegateOrderSendRequestState();
}

class _DelegateOrderSendRequestState extends State<DelegateOrderSendRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: appBarBackgroundColor),
        centerTitle: true,
        title: const Text(
          'Delegate',
          style: TextStyle(color: kUniversalColor),
        ),
        backgroundColor: appBarBackgroundColor,
        leading: InkWell(
          onTap: () {
            print("clicked");
            Navigator.pop(context);
          },
          child: const ImageIcon(
            AssetImage(AssetConfig.kBack),
            color: kUniversalColor,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are your sure you want to logout"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("No")),
                          TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()),
                                        (route) => false);
                                BlocProvider.of<AuthCubit>(context).logout();
                              },
                              child: Text("Yes")),
                        ],
                      );
                    });
                print("clicked");
              },
              child: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageIcon(
                  AssetImage(AssetConfig.kLogout),
                  color: kUniversalColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DelegateCubit, DelegateState>(
            builder: (context, state) {
          if (state.searchingGetUsers == "searching") {
            return Center(
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kUniversalColor),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        int userID = int.parse(pref.getString("id")!);
                        print("userID: $userID");

                        showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text("Delegate"),
                                content:
                                const Text("Are your sure you want to delegate this order?"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text("No")),
                                  TextButton(
                                      onPressed: () async {
                                        BlocProvider.of<DelegateCubit>(context)
                                            .assignOrder(
                                            userID: state.queryResultGetUsers!
                                                .data!['listUsers'][index]['id']);
                                        await BlocProvider.of<PickListCubit>(context).getOrders(userID: 9, orderStatusID: 1).then((value) {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushNamed(picklist);
                                        });
                                      },
                                      child: Text("Yes")),
                                ],
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.queryResultGetUsers!
                              .data!['listUsers'][index]['username']
                              .toString(),
                          style:
                              GoogleFonts.lato(fontSize: 18, color: kTextColor),
                        ),
                      ),
                    );
                  },
                  itemCount:
                      state.queryResultGetUsers!.data!['listUsers'].length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 2, color: Colors.black)),
            );
          }
        }),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<DelegateCubit>(context).getUsers();
  }
}

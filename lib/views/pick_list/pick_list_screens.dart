import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/constants.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:flutter_picker_app/views/pick_list/finished.dart';
import 'hold.dart';
import 'queue.dart';

class PickListScreens extends StatelessWidget {
  const PickListScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: appBarBackgroundColor),
          centerTitle: true,
          title: Text(
            'PickList',
            style: TextStyle(color: kUniversalColor),
          ),
          backgroundColor: appBarBackgroundColor,
          bottom: const TabBar(
            indicatorColor: kUniversalColor,
            labelColor: Colors.black,
            tabs: [
              Tab(text: "Queue"),
              Tab(text: "Hold"),
              Tab(text: "Finished"),
            ],
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
                          content:
                              const Text("Are your sure you want to logout"),
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
                },
                child: Padding(
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
        body: const TabBarView(
          children: [
            Queue(),
            Hold(),
            Finished(),
          ],
        ),
      ),
    );
  }
}

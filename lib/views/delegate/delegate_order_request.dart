import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/delegate/delegate_cubit.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class DelegateOrderReceiveRequest extends StatefulWidget {
  const DelegateOrderReceiveRequest({Key? key}) : super(key: key);

  @override
  _DelegateOrderReceiveRequestState createState() =>
      _DelegateOrderReceiveRequestState();
}

class _DelegateOrderReceiveRequestState
    extends State<DelegateOrderReceiveRequest> {
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
              if(state.searchingGetRequest == "searching") {
                return Center(
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kUniversalColor),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                      const Divider(
                        color: Colors.black,
                      ),
                      itemCount: state.queryResultGetRequest!
                          .data!['listOrdersFilters']['orders'].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.only(
                            left: 8,
                          ),
                          title: Text(
                              "Order ID: ${state.queryResultGetRequest!
                                  .data!['listOrdersFilters']['orders'][index]['id']}"),
                          subtitle: Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                        "${state.queryResultGetRequest!
                                            .data!['listOrdersFilters']['orders'][index]["date_added_format"]}",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w400)),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blueGrey),
                                      height: 15,
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${state.queryResultGetRequest!
                                      .data!['listOrdersFilters']['orders'][index]["order_products_count"]["total_count"]} Products",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Delivery Date: ${state.queryResultGetRequest!
                                      .data!['listOrdersFilters']['orders'][index]["delivery_date_format"]}",
                                  style: GoogleFonts.montserrat(
                                    color: kUniversalColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
        }),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<DelegateCubit>(context).getRequest(1);
  }
}

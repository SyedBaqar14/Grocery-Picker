import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/logic/cubit/packorder_cubit/packorder_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
    borderSide: BorderSide(color: kUniversalColor),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: appBarBackgroundColor),
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(color: kUniversalColor),
        ),
        backgroundColor: appBarBackgroundColor,
        leading: InkWell(
          onTap: () {
            print("clicked");
            Navigator.pop(context);
          },
          child: const ImageIcon(AssetImage(AssetConfig.kBack),
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
                        content:
                        const Text("Are your sure you want to logout"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("No")),
                          TextButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()),
                                      (route) => false),
                              child: Text("Yes")),
                        ],
                      );
                    });
                print("clicked");
              },
              child: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageIcon(AssetImage(AssetConfig.kLogout),
                  color: kUniversalColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<PackOrderCubit, PackOrderState>(
        builder: (context, state) {
          if (state.isLoaded == "Loading") {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kUniversalColor),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Order ID: ${state.orderID}",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (val) {
                            print("value: $val");
                            BlocProvider.of<PackOrderCubit>(context).filterSearchResults(val);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Search Item Here',
                            border: border,
                            errorBorder: border,
                            disabledBorder: border,
                            focusedBorder: border,
                            focusedErrorBorder: border,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Unpacked Items: (24)",
                      style: GoogleFonts.montserrat(
                          color: kUniversalColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(
                            color: Colors.black,
                          ),
                      shrinkWrap: true,
                      itemCount: state.orderDetailList.length,
                      itemBuilder: (context, i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  image: NetworkImage(state.orderDetailList[i].image!)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(state.orderDetailList[i].name!),
                                Text("item id: ${state.orderDetailList[i].id}"),
                                Text("Quanity: ${state.orderDetailList[i].qty}"),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MaterialButton(
          height: 40,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          minWidth: double.infinity,
          color: kUniversalColor,
          onPressed: () {
            Navigator.pushNamed(context, packorder);
          },
          child: Text(
            "Pack Order",
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<PackOrderCubit>(context).getOrder();
  }
}

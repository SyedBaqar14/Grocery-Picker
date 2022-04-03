import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/constants.dart';
import 'package:flutter_picker_app/data/model/order_details_model.dart';
import 'package:flutter_picker_app/data/model/pack_order_boxes.dart';
import 'package:flutter_picker_app/logic/cubit/packorder_cubit/packorder_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:flutter_picker_app/views/components/item_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackOrder extends StatefulWidget {
  const PackOrder({Key? key}) : super(key: key);

  @override
  _PackOrderState createState() => _PackOrderState();
}

class _PackOrderState extends State<PackOrder> {

  List<PackOrderBoxes> packOrderList = [];
  static int boxNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: appBarBackgroundColor),
        centerTitle: true,
        title: const Text(
          'Pack Order',
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
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()),
                                  (route) => false),
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
      body: BlocBuilder<PackOrderCubit, PackOrderState>(
          builder: (context, state) {
        if (state.isLoaded == "Loading") {
          return Center(
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kUniversalColor),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Order ID: ${state.queryResult!.data!['getOrder']['id']}",
                        style: GoogleFonts.montserrat(
                            color: kTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: kUniversalColor, width: 2)),
                        minWidth: double.infinity,
                        onPressed: () {
                          boxNumber += 1;
                          setState(() {
                            BlocProvider.of<PackOrderCubit>(context).addOrderPackage(packageID: boxNumber, packageName: "Box Number: ", packageStatusID: 0);
                            packOrderList.add(PackOrderBoxes(boxName: "Box Number: ", boxId: boxNumber, qty: 5));
                          });
                        },
                        child: Row(
                          children: [
                            ImageIcon(
                              AssetImage(AssetConfig.kAdd),
                              color: kUniversalColor,
                              size: 25,
                            ),
                            Text(
                              " New",
                              style: GoogleFonts.montserrat(
                                  color: kUniversalColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${state.totalProductsPackOrder} Products",
                  style: GoogleFonts.montserrat(
                      color: kTextSubColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Packed Boxes ($boxNumber)",
                  style: GoogleFonts.montserrat(
                      color: kUniversalColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 4.9,
                    width: double.infinity,
                    child: ListView.separated(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        separatorBuilder: (context, index) => const Divider(
                              color: Colors.black,
                            ),
                        itemCount: packOrderList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, boxdetails);
                            },
                            child: Row(
                              children: <Widget>[
                                const Image(image: AssetImage(AssetConfig.kbox)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Box Number: ${packOrderList[index].boxId}",
                                  style: GoogleFonts.montserrat(
                                      color: kTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  "${packOrderList[index].qty} Items",
                                  style: GoogleFonts.montserrat(
                                      color: kTextSubColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                          );
                        })),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.7,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Unpacked Items (${state.totalProductsPackOrder})",
                        style: GoogleFonts.montserrat(
                            color: kUniversalColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        // height: MediaQuery.of(context).size.height / 2,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: GridView.builder(
                            padding: EdgeInsets.all(8),
                            itemCount: state.orderDetailList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 3,
                                    crossAxisSpacing: 3),
                            itemBuilder: (ctx, i) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: ItemBottomSheet(
                                        index: i,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Image(
                                            height: 80,
                                            width: 100,
                                            alignment: Alignment.center,
                                            image: NetworkImage(
                                              state
                                                  .orderDetailList[i].image!,
                                            )),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 2),
                                          child: Text(
                                              state
                                                  .orderDetailList[i].name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                  color: kTextColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14))),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 2),
                                          child: Text(
                                              "item id: ${state.orderDetailList[i].id}",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                  color: kTextColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14))),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8.0, top: 2),
                                        child: Text(
                                            "Quanity: ${state.orderDetailList[i].qty}",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                color: kTextColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 24, left: 24),
        child: MaterialButton(
          height: 40,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: kUniversalColor, width: 2)),
          minWidth: double.infinity,
          onPressed: () {
            mmain();
            // Navigator.pushNamed(context, summary);
          },
          child: Text(
            "Finish",
            style: GoogleFonts.montserrat(
                color: kUniversalColor,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
        ),
      ),
    );
  }

  getOrder() async {
    await BlocProvider.of<PackOrderCubit>(context).getOrder().then((value) {

    });

  }

  void mmain() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<OrdersDetailsModel> orderList = [];

    for(var i = 0; i < 5; i++){
      orderList.add(
            OrdersDetailsModel(id: i.toString(), name: i.toString(), image: i.toString(), qty: i.toString()),
      );
    }

    Future.delayed(Duration(seconds: 2),(){
      print(orderList);
      List<String> sharedList = orderList.map((e) => json.encode(e)).toList();
      print(sharedList);
      prefs.setStringList('list', sharedList);
    });


    // Future.delayed(const Duration(seconds: 3),(){
    //   var l = prefs.getStringList('list');
    //   var ls = l!.map((e) => OrdersDetailsModel.fromMap(json.decode(e)));
    //   print(ls);
    // });



    // Encode and store data in SharedPreferences
    // final String encodedData = OrdersDetailsModel.encode([
    //   OrdersDetailsModel(id: value.data!['getOrder']['order_products'], name: name, image: image, qty: qty),

    // ]);

    // await prefs.setString('musics_key', encodedData);
    //
    // // Fetch and decode data
    // final String musicsString = await prefs.getString('musics_key');
    //
    // final List<Music> musics = Music.decode(musicsString);


  }

  @override
  void initState() {
    boxNumber = 0;
    getOrder();
  }
}

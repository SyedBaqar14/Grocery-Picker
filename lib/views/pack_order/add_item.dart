import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/constants.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:flutter_picker_app/views/components/item_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();

  const AddItem();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: appBarBackgroundColor),
          centerTitle: true,
          title: Text(
            'Add Item',
            style: TextStyle(color: kUniversalColor),
          ),
          backgroundColor: appBarBackgroundColor,
          leading: InkWell(
            onTap: () {
              print("clicked");
              Navigator.pop(context);
            },
            child: ImageIcon(
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Id: 26162-0005",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("status: ",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                  Text("Inprogress",
                      style: GoogleFonts.montserrat(
                          color: kInprogress,
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                  Spacer(),
                  Text("Packed items: (13)",
                      style: GoogleFonts.montserrat(
                          color: kUniversalColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: 6,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7, crossAxisCount: 3),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                                alignment: Alignment.center,
                                image: AssetImage("assets/image1.png")),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text("1 Kg Milk",
                                  style: GoogleFonts.montserrat(
                                      color: kTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14))),
                          Padding(
                              padding: EdgeInsets.only(left: 8, top: 2),
                              child: Text("Item ID: 1234",
                                  style: GoogleFonts.montserrat(
                                      color: kTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14))),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, top: 2),
                            child: Text("Packed Quantity: 3",
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 24.0, right: 24, left: 24 ),
          child: MaterialButton(
            color: kUniversalColor,
            height: 40,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), side: BorderSide(color: kUniversalColor, width: 2)),
            minWidth: double.infinity,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Finish",
              style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

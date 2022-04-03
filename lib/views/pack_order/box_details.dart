import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/constants.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxDetails extends StatefulWidget {
  @override
  _BoxDetailsState createState() => _BoxDetailsState();

  const BoxDetails();
}

class _BoxDetailsState extends State<BoxDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: appBarBackgroundColor),
          centerTitle: true,
          title: Text(
            'Box Detail',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("status: ",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                  Text("Finished",
                      style: GoogleFonts.montserrat(
                          color: kGreen,
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
                  return Card(
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
                  );
                },
              ),
              Spacer(),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: double.infinity,
                color: kUniversalColor,
                onPressed: () {
                  Navigator.pushNamed(context, addItem);
                },
                child: Text(
                  "Add Items",
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 2)),
                minWidth: double.infinity,
                color: Colors.white,
                onPressed: () {},
                child: Text(
                  "Remove Items",
                  style: GoogleFonts.montserrat(color: Colors.grey.shade500),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

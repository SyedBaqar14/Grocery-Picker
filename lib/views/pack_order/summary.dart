
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: appBarBackgroundColor),
        centerTitle: true,
        title: Text(
          'Summary',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID: 345648",
                        style: GoogleFonts.montserrat(
                            color: kTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(height: 3,),
                      Text(
                        "50 Products",
                        style: GoogleFonts.montserrat(
                            color: kTextSubColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), side: BorderSide(color: kUniversalColor, width: 2)),
                    minWidth: double.infinity,
                    onPressed: () {},
                    child: Row(
                      children: [
                        ImageIcon(AssetImage(AssetConfig.kPrint), color: kUniversalColor, size: 25,),
                        Text(
                          " Invoice",
                          style: GoogleFonts.montserrat(color: kUniversalColor, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 15,
            ),
            Text(
              "Packed Boxes (3)",
              style: GoogleFonts.montserrat(
                  color: kUniversalColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: ListView.separated(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          Image(image: AssetImage(AssetConfig.kbox)),
                          SizedBox(width: 10,),
                          Text(
                            "50 Products",
                            style: GoogleFonts.montserrat(
                                color: kTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            "13 Items",
                            style: GoogleFonts.montserrat(
                                color: kTextSubColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          SizedBox(width: 5,)
                        ],
                      );
                    })),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: double.infinity,
                color: kUniversalColor,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(bottomnav, (Route<dynamic> route) => false);
                },
                child: Text(
                  "Finish Order",
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 24),
              child: MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 2)),
                minWidth: double.infinity,
                color: Colors.white,
                onPressed: () {},
                child: Text(
                  "Remove Box",
                  style: GoogleFonts.montserrat(color: Colors.grey.shade500),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

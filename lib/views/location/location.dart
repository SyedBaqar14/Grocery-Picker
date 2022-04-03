import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image(image: AssetImage(AssetConfig.kLocation))),
              SizedBox(
                height: 15,
              ),
              Text(
                "Enable Your Location",
                style: GoogleFonts.montserrat(
                    color: kUniversalColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Choose your location to start find\nthe request around you",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                minWidth: double.infinity,
                color: kUniversalColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, signup);
                },
                child: Center(
                    child: Text(
                  "Use My Location",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

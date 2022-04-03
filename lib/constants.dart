import 'package:flutter/material.dart';

const Color themeColor = Color(0xffFE8086);
const Color kTextFieldFilledColor = Color(0xffE4F9E8);
const Color kUniversalColor = themeColor;
const Color kFiledColor = Color(0xffE4F9E8);
const Color kTextColor = Color(0xff666666);
const Color kTextSubColor = Color(0xffC7C7C7);
const Color kProduct = Color(0xffC7C7C7);
const Color kGreen = Color(0xff07B52D);
const Color kInprogress = Color(0xff1CB2B2);
const Color appBarBackgroundColor = Color(0xffFFFFFF);

Widget sizeBox10()=>const SizedBox(height: 10,);
Widget sizeBox20()=>const SizedBox(height: 20,);
Widget sizeBox30()=>const SizedBox(height: 30,);
Widget sizeBox50()=>const SizedBox(height: 50,);

double getDeviceHeight(BuildContext context)=> MediaQuery.of(context).size.height;
double getDeviceWidth(BuildContext context)=> MediaQuery.of(context).size.width;
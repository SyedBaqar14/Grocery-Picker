import 'package:flutter/material.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class ItemBottomSheet extends StatefulWidget {
  const ItemBottomSheet({Key? key, required this.index})
      : super(key: key);
  final int index;
  @override
  _ItemBottomSheetState createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {

  String itemDes =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when a galley of type and scrambled it to make a type specimen book  only five centuries, but also the leap into electronic typesetting, unchanged.";
  @override
  Widget build(BuildContext context) {
    // final data = widget.result.data?['listProductsFilter'];
    // var d = data['products'];
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                // bottomLeft: Radius.circular(100),
                // bottomRight: Radius.circular(20),
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetConfig.kMilkPackFull) as ImageProvider),
              // color: Colors.white,
            ),
            height: height / 3,
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "product name",
                    style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        "Item Id: ",
                        style: GoogleFonts.montserrat(color: kUniversalColor, fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "1234",
                        style: GoogleFonts.montserrat(color: kTextColor, fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Item Quantity: 3",
                    style: GoogleFonts.montserrat(color: kTextSubColor, fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), side: BorderSide(color: kUniversalColor, width: 2)),
                        minWidth: 10,
                        onPressed: () {
                        },
                        child: Icon(Icons.remove, color: kUniversalColor,),
                      ),
                      SizedBox(width: 10,),
                      Container( height: 40, width: 45, decoration: BoxDecoration(borderRadius: new BorderRadius.circular(8.0),color: Color(0xffE4F9E8)), child: Center(child: Text("1", style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),))),
                      SizedBox(width: 10,),
                      MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), side: BorderSide(color: kUniversalColor, width: 2)),
                        minWidth: 10,
                        onPressed: () {
                        },
                        child: Icon(Icons.add, color: kUniversalColor,)
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: MaterialButton(
                          color: kUniversalColor,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), side: BorderSide(color: kUniversalColor, width: 2)),
                            minWidth: 50,
                            onPressed: () {
                            Navigator.pop(context);
                            },
                            child: Text("Add to Box", style: TextStyle(color: Colors.white, ),)
                        ),
                      ),
                    ],
                  )
                  // AddToCart(d: d, index: widget.index, itemQty: 1, initQuantity: true)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

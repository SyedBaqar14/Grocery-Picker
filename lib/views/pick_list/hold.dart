import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/constants.dart';
import 'package:flutter_picker_app/logic/cubit/packorder_cubit/packorder_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/picklist_cubit/picklist_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class Hold extends StatefulWidget {
  const Hold({
    Key? key,
  }) : super(key: key);

  @override
  State<Hold> createState() => _HoldState();
}

class _HoldState extends State<Hold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PickListCubit, PickListState>(
          builder: (context, state) {
            if (state.searchingHold == "searching") {
              return Center(
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kUniversalColor),
                ),
              );
            } else {
              return ListView.separated(
                padding: EdgeInsets.only(top: 8, left: 8),
                separatorBuilder: (context, index) =>
                    Divider(
                      color: Colors.black,
                    ),
                itemCount: state.queryResultHoldOrder!
                    .data!['listOrdersFilters']['orders'].length,
                itemBuilder: (context, index) {
                  return Slidable(
                    // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        dragDismissible: false,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: (context) => details(
                                context: context,
                                orderID:
                                state.queryResultHoldOrder!.data!['listOrdersFilters']
                                ['orders'][index]['id']),
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            label: 'Detail',
                          ),
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) => unHold(context: context, statusID: 1, orderID: state.queryResultHoldOrder!.data!['listOrdersFilters']['orders'][index]['id']),
                            backgroundColor: kUniversalColor,
                            foregroundColor: Colors.white,
                            label: 'UnHold',
                          ),
                        ],
                      ),
                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: ListTile(contentPadding: EdgeInsets.only(left: 8),
                        title: Text("Order ID: ${state.queryResultHoldOrder!
                            .data!['listOrdersFilters']['orders'][index]['id']}"),
                        subtitle: Padding(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                          Text(
                          "${state.
                              queryResultHoldOrder!.data!['listOrdersFilters']
                              ['orders'][index]["date_added_format"]}",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400)),
                          Text(
                            "${state.queryResultHoldOrder!
                                .data!['listOrdersFilters']['orders'][index]["order_products_count"]["total_count"]} Products",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Delivery Date: ${state.queryResultHoldOrder!
                                .data!['listOrdersFilters']['orders'][index]["delivery_date_format"]}",
                            style: GoogleFonts.montserrat(
                              color: kUniversalColor,
                            ),
                          )
                            ],
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      )
                  );
                },
              );
            }
          }
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<PickListCubit>(context).getOrders(
        userID: 9, orderStatusID: 13);
  }
}

void unHold({required BuildContext context, required int orderID, required int statusID}) async {
  final packOrderCubit = BlocProvider.of<PickListCubit>(context);
  await BlocProvider.of<PickListCubit>(context).updateOrderStatus(orderID: orderID, orderStatus: statusID).then((value) async {
    await packOrderCubit.getOrders(userID: 9, orderStatusID: 13);
  });
}

void details({required BuildContext context, required int orderID}) async {
  await BlocProvider.of<PackOrderCubit>(context).setOrderID(orderID);
  Navigator.pushNamed(context, orderdetails);
}


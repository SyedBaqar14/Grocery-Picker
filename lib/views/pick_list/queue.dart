import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/constants.dart';
import 'package:flutter_picker_app/logic/cubit/delegate/delegate_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/packorder_cubit/packorder_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/picklist_cubit/picklist_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class Queue extends StatefulWidget {
  const Queue({
    Key? key,
  }) : super(key: key);

  @override
  State<Queue> createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<PickListCubit, PickListState>(builder: (context, state) {
        if (state.searchingPending == "searching") {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kUniversalColor),
            ),
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 8, left: 8),
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            itemCount: state.queryResultPendinOrder!
                .data!['listOrdersFilters']['orders'].length,
            itemBuilder: (context, index) {
              print(state.queryResultPendinOrder!
                  .data!['listOrdersFilters']['orders'].length);
              return InkWell(
                onTap: () async {
                  await BlocProvider.of<PackOrderCubit>(context).setOrderID(
                      state.queryResultPendinOrder!.data!['listOrdersFilters']
                          ['orders'][index]['id']);
                  Navigator.pushNamed(context, packorder);
                },
                child: Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: ActionPane(
                      dragDismissible: false,
                      extentRatio: 0.7,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 3,
                          onPressed: (context) => details(
                              context: context,
                              orderID: state.queryResultPendinOrder!
                                      .data!['listOrdersFilters']['orders']
                                  [index]['id']),
                          backgroundColor: const Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          label: 'Detail',
                        ),
                        SlidableAction(
                          flex: 3,
                          onPressed: (context) => hold(
                              context: context,
                              orderID: state.queryResultPendinOrder!
                                      .data!['listOrdersFilters']['orders']
                                  [index]['id'],
                              statusID: 13),
                          backgroundColor: kUniversalColor,
                          foregroundColor: Colors.white,
                          label: 'Hold',
                        ),
                        SlidableAction(
                          flex: 3,
                          onPressed: (context) => delegate(
                              context: context,
                              orderID: state.queryResultPendinOrder!
                                      .data!['listOrdersFilters']['orders']
                                  [index]['id']),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          label: 'Delegate',
                        ),
                      ],
                    ),
                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 8,
                      ),
                      title: Text(
                          "Order ID: ${state.queryResultPendinOrder!.data!['listOrdersFilters']['orders'][index]['id']}"),
                      subtitle: Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "${state.queryResultPendinOrder!.data!['listOrdersFilters']['orders'][index]["date_added_format"]}",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400)),
                            Text(
                              "${state.queryResultPendinOrder!.data!['listOrdersFilters']['orders'][index]["order_products_count"]["total_count"]} Products",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Delivery Date: ${state.queryResultPendinOrder!.data!['listOrdersFilters']['orders'][index]["delivery_date_format"]}",
                              style: GoogleFonts.montserrat(
                                color: kUniversalColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    )),
              );
            },
          );
        }
      }),
    );
  }

  @override
  void initState() {
    BlocProvider.of<PickListCubit>(context)
        .getOrders(userID: 9, orderStatusID: 1);
  }
}

void details({required BuildContext context, required int orderID}) async {
  await BlocProvider.of<PackOrderCubit>(context).setOrderID(orderID);
  Future.delayed(Duration(seconds: 1));
  Navigator.pushNamed(context, orderdetails);
}

void hold(
    {required BuildContext context,
    required int orderID,
    required int statusID}) async {
  final packOrderCubit = BlocProvider.of<PickListCubit>(context);
  await BlocProvider.of<PickListCubit>(context)
      .updateOrderStatus(orderID: orderID, orderStatus: statusID)
      .then((value) async {
    await packOrderCubit.getOrders(userID: 9, orderStatusID: 1);
  });
}

void delegate({required BuildContext context, required int orderID}) async {
  // final packOrderCubit = BlocProvider.of<PickListCubit>(context);
  // await BlocProvider.of<PickListCubit>(context).updateOrderStatus(
  //     orderID: orderID, orderStatus: statusID).then((value) async {
  //   await packOrderCubit.getPendingOrders(9);
  // });

  final delegateOrder =
      BlocProvider.of<DelegateCubit>(context).setOrderID(orderID: orderID);
  Navigator.pushNamed(context, delegateSendRequest);
}

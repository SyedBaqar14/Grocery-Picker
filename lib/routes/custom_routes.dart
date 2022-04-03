import 'package:flutter/material.dart';
import 'package:flutter_picker_app/config/bottom_nav.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:flutter_picker_app/views/authentication/signin/sign_up.dart';
import 'package:flutter_picker_app/views/authentication/signin/verify_email.dart';
import 'package:flutter_picker_app/views/delegate/dalegate_order_send.dart';
import 'package:flutter_picker_app/views/delegate/delegate_order_request.dart';
import 'package:flutter_picker_app/views/location/location.dart';
import 'package:flutter_picker_app/views/order_details.dart';
import 'package:flutter_picker_app/views/pack_order/add_item.dart';
import 'package:flutter_picker_app/views/pack_order/pack_order.dart';
import 'package:flutter_picker_app/views/pack_order/summary.dart';
import 'package:flutter_picker_app/views/pack_order/box_details.dart';
import 'package:flutter_picker_app/views/pick_list/pick_list_screens.dart';
import 'package:flutter_picker_app/views/splash.dart';

import '../not_found.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case picklist:
        return MaterialPageRoute(builder: (_) => const PickListScreens());
      case boxdetails:
        return MaterialPageRoute(builder: (_) => const BoxDetails());
      case orderdetails:
        return MaterialPageRoute(builder: (_) => OrderDetails());
      case bottomnav:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case location:
        return MaterialPageRoute(builder: (_) => Location());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmail());
      case packorder:
        return MaterialPageRoute(builder: (_) => const PackOrder());
      case summary:
        return MaterialPageRoute(builder: (_) => const Summary());
      case addItem:
        return MaterialPageRoute(builder: (_) => const AddItem());
      case delegateSendRequest:
        return MaterialPageRoute(builder: (_) => const DelegateOrderSendRequest());
      case delegateReceiveRequest:
        return MaterialPageRoute(builder: (_) => const DelegateOrderReceiveRequest());
    }
    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}

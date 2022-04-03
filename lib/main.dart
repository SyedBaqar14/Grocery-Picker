import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/delegate/delegate_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/packorder_cubit/packorder_cubit.dart';
import 'package:flutter_picker_app/logic/cubit/picklist_cubit/picklist_cubit.dart';
import 'package:flutter_picker_app/routes/custom_routes.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';
import 'package:google_fonts/google_fonts.dart';

import 'logic/cubit/init/init_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitCubit>(create: (context) => InitCubit()),
        BlocProvider<PickListCubit>(create: (context) => PickListCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<PackOrderCubit>(create: (context) => PackOrderCubit()),
        BlocProvider<DelegateCubit>(create: (context) => DelegateCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery Pickker',
        theme: ThemeData(
          textTheme: TextTheme(
            // caption: GoogleFonts.montserrat(),
            bodyText2: GoogleFonts.montserrat(),
            // bodyText1: GoogleFonts.montserrat(),
          ),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: CustomRoutes.allRoutes,
        initialRoute: splash,
      ),
    );
  }
}

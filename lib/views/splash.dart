import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker_app/config/asset_config.dart';
import 'package:flutter_picker_app/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_picker_app/routes/routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    final cub = BlocProvider.of<AuthCubit>(context);
    cub.getSharedData();
    Future.delayed(const Duration(seconds: 3), () {
      if (cub.userId == '' || cub.userId == null) {
        Navigator.pushReplacementNamed(context, signup);
        // not varified
      } else {
        Navigator.pushReplacementNamed(context, bottomnav);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            fit: BoxFit.fill,
            image: const AssetImage(AssetConfig.kSplashBgImage),
          ),
        ),
        child: Center(
          child: Image.asset(AssetConfig.kLogo),
        ),
      ),
    );
  }
}

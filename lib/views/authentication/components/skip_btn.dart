// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class SkipBtn extends StatelessWidget {
  final VoidCallback onTap;
   // ignore: use_key_in_widget_constructors
   SkipBtn({Key? key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: const Text("Skip"),
        ),
      ],
    );
  }
}

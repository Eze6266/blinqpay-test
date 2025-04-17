// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:blinqpay/Utilities/app_colors.dart';
import 'package:blinqpay/Utilities/reusables.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 80,
              color: kColors.textGrey.withOpacity(0.8),
            ),
            Height(h: 2),
            kTxt(
              text: "No Internet Connection",
              size: 18,
              weight: FontWeight.w500,
              textalign: TextAlign.center,
            ),
            Height(h: 0.5),
            kTxt(
              text: "Please check your connection and try again.",
              size: 14,
              color: kColors.textGrey,
              textalign: TextAlign.center,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:blinqpay/Utilities/Functions/theme_coloring.dart';
import 'package:blinqpay/Utilities/app_colors.dart';
import 'package:blinqpay/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Shimmer.fromColors(
      baseColor: themedColor(
        light: Colors.grey[100]!,
        dark: kColors.textGrey,
      ),
      highlightColor: themedColor(
        light: kColors.whitishGrey,
        dark: kColors.whiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: List.generate(6, (index) => buildShimmerItem(size)),
        ),
      ),
    );
  }

  Widget buildShimmerItem(Size size) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.2 * size.height / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Height(h: 1),
          Container(
            width: double.infinity,
            height: 10 * size.height / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

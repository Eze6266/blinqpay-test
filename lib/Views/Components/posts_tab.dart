// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:blinqpay/Utilities/Functions/theme_coloring.dart';
import 'package:blinqpay/Utilities/app_colors.dart';
import 'package:blinqpay/Utilities/image_constants.dart';
import 'package:blinqpay/Utilities/lazy_loaders.dart';
import 'package:blinqpay/Utilities/reusables.dart';
import 'package:blinqpay/Views/Components/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('post')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Center(child: MyLoader());
        }

        final posts = snapshot.data!.docs;

        if (posts.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kImages.emptysvg,
                height: 5 * size.height / 100,
                color: themedColor(
                  light: kColors.blackColor,
                  dark: kColors.whiteColor,
                ),
              ),
              Height(h: 1),
              kTxt(
                text:
                    'Your posts are displayed here\nLooks like you don\'t have any',
                textalign: TextAlign.center,
                size: 12,
                color: themedColor(
                  light: kColors.blackColor,
                  dark: kColors.whiteColor,
                ),
              ),
            ],
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(post: posts[index]);
          },
          separatorBuilder: (context, index) => Divider(
            color: kColors.whitishGrey,
            thickness: 0.5,
          ),
        );
      },
    );
  }
}

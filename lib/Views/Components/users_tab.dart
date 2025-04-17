// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:blinqpay/Utilities/Functions/theme_coloring.dart';
import 'package:blinqpay/Utilities/app_colors.dart';
import 'package:blinqpay/Utilities/image_constants.dart';
import 'package:blinqpay/Utilities/lazy_loaders.dart';
import 'package:blinqpay/Utilities/reusables.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: MyLoader(),
          );
        final users = snapshot.data!.docs;

        return users.isEmpty == false
            ? Column(
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
                        'Active users are displayed here\n Looks like you don\'t have any',
                    textalign: TextAlign.center,
                    size: 12,
                    color: themedColor(
                      light: kColors.blackColor,
                      dark: kColors.whiteColor,
                    ),
                  )
                ],
              )
            : ListView.builder(
                padding: EdgeInsets.only(
                  top: 2 * size.height / 100,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 1.5 * size.height / 100,
                      right: 2 * size.width / 100,
                      left: 2 * size.width / 100,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  width: double.infinity,
                                  height: double.infinity,
                                  imageUrl: user['photo'],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    child: Icon(
                                      Icons.person_3_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Width(w: 3),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                kTxt(
                                  text: user['username'],
                                  weight: FontWeight.w600,
                                  size: 16,
                                  color: themedColor(
                                    light: kColors.blackColor,
                                    dark: kColors.whiteColor,
                                  ),
                                ),
                                kTxt(
                                  text: user['bio'],
                                  weight: FontWeight.w400,
                                  size: 14,
                                  maxLine: 5,
                                  color: themedColor(
                                    light: kColors.blackColor.withOpacity(0.8),
                                    dark: kColors.whitishGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Height(h: 0.5),
                        Divider(color: kColors.whitishGrey.withOpacity(0.4)),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}

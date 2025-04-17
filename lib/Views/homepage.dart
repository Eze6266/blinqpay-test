// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:blinqpay/Utilities/Functions/theme_coloring.dart';
import 'package:blinqpay/Utilities/Functions/time_formatter.dart';
import 'package:blinqpay/Utilities/app_colors.dart';
import 'package:blinqpay/Utilities/reusables.dart';
import 'package:blinqpay/Views/Components/post_card.dart';
import 'package:blinqpay/Views/Components/posts_tab.dart';
import 'package:blinqpay/Views/Components/users_tab.dart';
import 'package:blinqpay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: themedColor(
          light: kColors.whiteColor,
          dark: kColors.blackColor,
        ),
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  themeNotifier.value = themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: 5 * size.width / 100),
                child: Icon(
                  Icons.contrast_outlined,
                  size: 26,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
          title: kTxt(
            text: 'BlinqPay-Test',
            size: 20,
            color: themedColor(
              light: kColors.blackColor,
              dark: kColors.whiteColor,
            ),
            weight: FontWeight.w500,
          ),
          centerTitle: true,
          backgroundColor: themedColor(
            light: kColors.dimOrange,
            dark: kColors.darkPrimaryColor,
          ),
          bottom: TabBar(
            labelColor: themedColor(
              light: kColors.blackColor,
              dark: kColors.whiteColor,
            ),
            unselectedLabelColor: themedColor(
              light: kColors.textGrey,
              dark: kColors.whitishGrey.withOpacity(0.6),
            ),
            labelStyle: TextStyle(
              fontFamily: 'Rany',
              fontWeight: FontWeight.w500,
              color: themedColor(
                light: kColors.blackColor,
                dark: kColors.whiteColor,
              ),
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: themedColor(
                  light: kColors.blackColor,
                  dark: kColors.whiteColor,
                ),
              ),
              insets: EdgeInsets.symmetric(
                horizontal: 25 * size.width / 100,
              ),
            ),
            tabs: [
              Tab(
                text: "Posts",
              ),
              Tab(
                text: "Users",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PostsSection(),
            UsersSection(),
          ],
        ),
      ),
    );
  }
}

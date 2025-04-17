import 'dart:math';

import 'package:blinqpay/Utilities/app_colors.dart';
import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  Height({
    super.key,
    required this.h,
  });
  double h;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(height: h * size.height / 100);
  }
}

class Width extends StatelessWidget {
  Width({
    super.key,
    required this.w,
  });
  double w;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(width: w * size.width / 100);
  }
}

class kTxt extends StatelessWidget {
  kTxt(
      {super.key,
      this.color,
      this.size,
      required this.text,
      this.weight,
      this.textalign,
      this.letterSpace,
      this.maxLine,
      this.softRap,
      s});
  String text;
  Color? color;
  double? size, letterSpace;
  TextAlign? textalign;
  FontWeight? weight;
  int? maxLine;
  bool? softRap;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        fontFamily: 'Rany',
        color: color ?? kColors.blackColor,
        fontSize: size ?? 14.0,
        fontWeight: weight ?? FontWeight.w400,
        decoration: TextDecoration.none,
        letterSpacing: letterSpace ?? 0,
      ),
      textAlign: textalign ?? TextAlign.left,
      softWrap: softRap ?? false,
      maxLines: maxLine ?? null,
      overflow: TextOverflow.ellipsis,
    );
  }
}

void goTo(BuildContext context, Widget screen) {
  final random = Random();
  final animations = [
    // _fadeTransition,
    // _scaleTransition,
    _slideTransition, // Added slide transition
  ];
  final randomAnimation = animations[random.nextInt(animations.length)];

  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: randomAnimation,
    ),
  );
}

Widget _fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
    child: child,
  );
}

Widget _scaleTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  const begin = 0.0;
  const end = 1.0;
  const curve = Curves.easeInOutBack;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var scaleAnimation = animation.drive(tween);

  return ScaleTransition(
    scale: scaleAnimation,
    child: child,
  );
}

Widget _slideTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  const begin = Offset(1.0, 0.0); // Start from right
  const end = Offset.zero; // End at normal position
  const curve = Curves.easeInOut;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

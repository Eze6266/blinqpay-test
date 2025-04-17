import 'package:blinqpay/main.dart';

import 'package:flutter/material.dart';

Color themedColor({required Color light, required Color dark}) {
  return themeNotifier.value == ThemeMode.light ? light : dark;
}

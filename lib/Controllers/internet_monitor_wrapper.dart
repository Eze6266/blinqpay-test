import 'package:blinqpay/Views/Components/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetMonitor extends StatefulWidget {
  final Widget child;
  const InternetMonitor({required this.child, super.key});

  @override
  State<InternetMonitor> createState() => _InternetMonitorState();
}

class _InternetMonitorState extends State<InternetMonitor> {
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInternet();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        hasInternet = result != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkInternet() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!hasInternet) const NoInternetScreen(), // Fullscreen overlay
      ],
    );
  }
}

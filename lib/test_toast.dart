import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestToast extends StatefulWidget {
  const TestToast({super.key});

  @override
  State<TestToast> createState() => _TestToastState();
}

class _TestToastState extends State<TestToast> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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

  void _showToast() {
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: const Text('Hello, world!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

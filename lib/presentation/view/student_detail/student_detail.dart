import 'package:flutter/material.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({super.key});

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail'),
      ),
      body: const Center(
        child: Text('Student Detail'),
      ),
    );
  }
}

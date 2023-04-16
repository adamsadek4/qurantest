import 'package:flutter/material.dart';


class teacher extends StatefulWidget {
  const teacher({super.key});

  @override
  State<teacher> createState() => _teacherState();
}

class _teacherState extends State<teacher> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('شرح الاية  '),),
    );
  }
}
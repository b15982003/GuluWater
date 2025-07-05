
import 'package:flutter/material.dart';

class AddRecordPage extends StatelessWidget{
  const AddRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text('新增數據'),
    );
    return Scaffold(
      appBar: appBar,
      body: const Center(
        child: Text('Add Record Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
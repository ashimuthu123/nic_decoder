import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/nic_controller.dart';
import 'screens/input_screen.dart';

void main() {
  Get.put(NICController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sri Lankan NIC Decoder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const InputScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
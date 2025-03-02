// lib/screens/input_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nic_controller.dart';
import '../screens/result_screen.dart';

// Screen for NIC number input
class InputScreen extends StatelessWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NICController>();
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sri Lankan NIC Decoder'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your NIC Number',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NIC Number',
                  hintText: 'e.g., 853400937V or 198534000937',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              Obx(() => controller.errorMessage.isNotEmpty
                  ? Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.decodeNIC(textController.text)) {
                    Get.to(() => const ResultScreen());
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Decode',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

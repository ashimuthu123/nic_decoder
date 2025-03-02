import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nic_controller.dart';

/// Screen to display the decoded NIC information
class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NICController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decoded NIC Information'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInfoCard(
                  'Format',
                  controller.format.value,
                  Icons.format_list_numbered,
                ),
                _buildInfoCard(
                  'Date of Birth',
                  controller.dateOfBirth.value,
                  Icons.calendar_today,
                ),
                _buildInfoCard(
                  'Day of Week',
                  controller.weekday.value,
                  Icons.view_week,
                ),
                _buildInfoCard(
                  'Age',
                  '${controller.age.value} years',
                  Icons.person,
                ),
                _buildInfoCard(
                  'Gender',
                  controller.gender.value,
                  controller.gender.value == 'Male'
                      ? Icons.male
                      : Icons.female,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Decode Another NIC',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  /// Helper method to build consistent info cards
  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

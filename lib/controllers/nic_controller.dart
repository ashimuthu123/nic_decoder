import 'package:get/get.dart';
import 'package:intl/intl.dart';

// manage NIC decoding logic
class NICController extends GetxController {
  
  var nicNumber = ''.obs;
  var isValidNIC = false.obs;
  var errorMessage = ''.obs;
  
  
  var format = ''.obs;
  var dateOfBirth = ''.obs;
  var weekday = ''.obs;
  var age = 0.obs;
  var gender = ''.obs;
  var votingStatus = ''.obs;
  var serialNumber = ''.obs;


  bool decodeNIC(String nic) {
    
    errorMessage.value = '';
    
    String cleanNIC = nic.replaceAll(RegExp(r'[\s-]'), '');
    nicNumber.value = cleanNIC;
    
    if (_isOldFormat(cleanNIC)) {
      format.value = 'Old (9-digit)';
      return _decodeOldFormat(cleanNIC);
    } else if (_isNewFormat(cleanNIC)) {
      format.value = 'New (12-digit)';
      return _decodeNewFormat(cleanNIC);
    } else {
      errorMessage.value = 'Invalid NIC format. Please enter a valid Sri Lankan NIC number.';
      isValidNIC.value = false;
      return false;
    }
  }

  /// Checks if the NIC is in the old
  bool _isOldFormat(String nic) {
    return RegExp(r'^[0-9]{9}[vVxX]$').hasMatch(nic);
  }

  /// Checks if the NIC is in the new
  bool _isNewFormat(String nic) {
    return RegExp(r'^[0-9]{12}$').hasMatch(nic);
  }

  /// Decodes the old format NIC
  bool _decodeOldFormat(String nic) {
    try {
      // Extract year
      int year = int.parse(nic.substring(0, 2));
      // Add century prefix
      String fullYear = (year >= 0 && year <= 24) ? '20$year' : '19$year';
      
      // Extract day of year 
      int dayOfYear = int.parse(nic.substring(2, 5));
      
      // Determine gender
      if (dayOfYear >= 500) {
        gender.value = 'Female';
        dayOfYear -= 500;
      } else {
        gender.value = 'Male';
      }
      
      // Extract date info
      DateTime date = _getDayOfYear(int.parse(fullYear), dayOfYear);
      dateOfBirth.value = DateFormat('MMMM d, yyyy').format(date);
      weekday.value = DateFormat('EEEE').format(date);
      
      // Calculate age
      age.value = DateTime.now().year - int.parse(fullYear);
      if (DateTime.now().month < date.month || 
          (DateTime.now().month == date.month && DateTime.now().day < date.day)) {
        age.value--;
      }
      
      // Extract serial number
      serialNumber.value = nic.substring(5, 9);
      
      isValidNIC.value = true;
      return true;
    } catch (e) {
      errorMessage.value = 'Error decoding NIC: $e';
      isValidNIC.value = false;
      return false;
    }
  }

  // Decodes the new format NIC
  bool _decodeNewFormat(String nic) {
    try {
      // Extract year 
      String fullYear = nic.substring(0, 4);
      
      // Extract day of year 
      int dayOfYear = int.parse(nic.substring(4, 7));
      
      // Determine gender
      if (dayOfYear >= 500) {
        gender.value = 'Female';
        dayOfYear -= 500;
      } else {
        gender.value = 'Male';
      }
      
      // Extract date info
      DateTime date = _getDayOfYear(int.parse(fullYear), dayOfYear);
      dateOfBirth.value = DateFormat('MMMM d, yyyy').format(date);
      weekday.value = DateFormat('EEEE').format(date);
      
      // Calculate age
      age.value = DateTime.now().year - int.parse(fullYear);
      if (DateTime.now().month < date.month || 
          (DateTime.now().month == date.month && DateTime.now().day < date.day)) {
        age.value--;
      }
      
      serialNumber.value = nic.substring(7, 12);
      
      isValidNIC.value = true;
      return true;
    } catch (e) {
      errorMessage.value = 'Error decoding NIC: $e';
      isValidNIC.value = false;
      return false;
    }
  }

  // Converts a day of year to an actual date
  DateTime _getDayOfYear(int year, int dayOfYear) {
    final firstDay = DateTime(year, 1, 1);
    return firstDay.add(Duration(days: dayOfYear - 1));
  }
}

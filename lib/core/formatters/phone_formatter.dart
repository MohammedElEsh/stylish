abstract class PhoneFormatter {
  static String format(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 11) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    }
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    }
    return phone;
  }

  static String strip(String phone) {
    return phone.replaceAll(RegExp(r'\D'), '');
  }

  static bool isValid(String phone) {
    final digits = strip(phone);
    return digits.length >= 7 && digits.length <= 15;
  }
}

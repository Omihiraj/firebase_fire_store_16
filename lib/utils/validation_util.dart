class ValidationUtil {
  static RegExp numbersRegex = RegExp(r'^[0-9]*$');

  static String? nameFieldValidator({required String name}) {
    if (name.isEmpty) {
      return "Name field cannot be empty";
    }
    return null;
  }

  static String? addressFieldValidator({required String address}) {
    if (address.isEmpty) {
      return "Address field cannot be empty";
    }
    return null;
  }

  static String? ageFieldValidator({required String age}) {
    if (age.isEmpty) {
      return "Age field cannot be empty";
    } else if (!numbersRegex.hasMatch(age)) {
      return "Enter valid age";
    } else if (int.parse(age) < 18 || int.parse(age) > 60) {
      return "Enter between 18 and 60";
    }
    return null;
  }
}

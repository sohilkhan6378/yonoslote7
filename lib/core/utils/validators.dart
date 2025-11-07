class Validators {
  static bool isValidPan(String pan) {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}\$').hasMatch(pan);
  }
}

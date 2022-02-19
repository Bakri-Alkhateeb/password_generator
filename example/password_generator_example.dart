// We first import the package
import 'package:password_generator/src/password_generator.dart';

void main() {
  // Then we initialize the PasswordGenerator class
  final _passwordGenerator = PasswordGenerator(
    length: 21,
    hasCapitalLetters: true,
    hasNumbers: true,
    hasSmallLetters: true,
    hasSymbols: true,
  );

  // We call the generatePassword method on the PasswordGenerator instance
  // that returns a String.
  final String _password = _passwordGenerator.generatePassword();

  // If we like, we can check the strength of the password by calling the checkStrength method
  // which is an extension of the String type to enable us to use it without
  // initializing the PasswordGenerator class.
  final double _entropy = _password.checkStrength();

  // We then check the entropy value and print information related to the specified ranges.
  if (_entropy >= 128) {
    print('Extremely Strong.');
  } else if (_entropy >= 60) {
    print('Very Strong.');
  } else if (_entropy >= 36) {
    print('Strong.');
  } else if (_entropy >= 28) {
    print('Ok.');
  } else if (_entropy >= 18) {
    print('Weak.');
  } else {
    print("Extremely Weak.");
  }
}

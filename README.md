A package to generate strong passwords. Also comes with an extension for checking the strength of a password.

## Features

You can use this package in your dart or flutter projects to:

* Generate strong passwords.
* Check the strength of any password.

## Getting started

The package should work out of the box after installing and importing it.

## Usage

The following example demonstrates how to use the package properly: 

```dart
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
```

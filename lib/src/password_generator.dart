import 'dart:math' as _math;

import 'package:password_generator/src/constants.dart';

extension CheckStrength on String? {
  /// An extension on the [String] type to make you able to check the strength of
  /// any string without the need to initialize the [PasswordGenerator] class.
  ///
  /// The extension returns the entropy of the string provided, the bigger the entropy
  /// the stronger the string.
  ///
  /// The entropy gets calculated considering the string length, how many capital
  /// letters it contains, how many small letters it contains, how many numbers
  /// it contains and how many symbols it contains.
  ///
  /// Ranges Are:
  ///
  /// More than or equal to 128: Extremely Strong.
  ///
  /// More than or equal to 60: Very Strong.
  ///
  /// More than or equal to 36: Strong.
  ///
  /// More than or equal to 28: Ok.
  ///
  /// More than or equal to 18: Weak.
  ///
  /// Less than 18: Extremely Weak.
  ///
  /// Example:
  ///
  /// ```
  /// final double _entropy = _password.checkStrength();
  ///
  ///   if (_entropy >= 128) {
  ///     print('Extremely Strong.');
  ///   } else if (_entropy >= 60) {
  ///     print('Very Strong.');
  ///   } else if (_entropy >= 36) {
  ///     print('Strong.');
  ///   } else if (_entropy >= 28) {
  ///     print('Ok.');
  ///   } else if (_entropy >= 18) {
  ///     print('Weak.');
  ///   } else {
  ///     print('Extremely Weak.');
  ///   }
  /// ```
  double checkStrength() {
    if (this != null) {
      if (this!.isNotEmpty) {
        int _pool = 0,
            _smallLettersCount = 0,
            _capitalLettersCount = 0,
            _numbersCount = 0,
            _symbolsCount = 0;

        for (int i in this!.runes) {
          if (capitalLetters.runes.contains(i)) {
            _capitalLettersCount += 1;
          }

          if (smallLetters.runes.contains(i)) {
            _smallLettersCount += 1;
          }

          if (numbers.runes.contains(i)) {
            _numbersCount += 1;
          }

          if (symbols.runes.contains(i)) {
            _symbolsCount += 1;
          }
        }

        if (_smallLettersCount > 0) {
          _pool += 26;
        }

        if (_capitalLettersCount > 0) {
          _pool += 26;
        }

        if (_numbersCount > 0) {
          _pool += 10;
        }

        if (_symbolsCount > 0) {
          _pool += 32;
        }

        int _length = _smallLettersCount +
            _capitalLettersCount +
            _numbersCount +
            _symbolsCount;

        var _entropy = _length * _math.log(_pool) / _math.log(2);

        if (_pool > 0) {
          return _entropy;
        }
      }
    }

    return 0;
  }
}

/// [PasswordGenerator] is a class that can be used to generate strong passwords
/// to be used in all kinds of applications.
///
/// Example:
/// ```
/// final _passwordGenerator = PasswordGenerator(
///     length: 10,
///     hasCapitalLetters: true,
///     hasNumbers: true,
///     hasSmallLetters: true,
///     hasSymbols: true,
///   );
///
/// final String _password = _passwordGenerator.generatePassword();
/// ```
class PasswordGenerator {
  /// A boolean value to tell if the password should have capital letters
  /// in it or not. defaults to true.
  late final bool hasCapitalLetters;

  /// A boolean value to tell if the password should have small letters in
  /// it or not. defaults to true.
  late final bool hasSmallLetters;

  /// A boolean value to tell if the password should have numbers in it or not.
  /// defaults to true.
  late final bool hasNumbers;

  /// A boolean value to tell if the password should have symbols in it or not.
  /// defaults to true.
  late final bool hasSymbols;

  /// An integer value that indicates the length of the password.
  /// defaults to 10.
  late final int length;

  /// Generates new random password.
  String generatePassword() {
    final List<String> _chars = [];
    final _random = _math.Random.secure();
    String _password = "";

    if (hasCapitalLetters) {
      _chars.addAll(capitalLetters.split(','));
    }

    if (hasSmallLetters) {
      _chars.addAll(smallLetters.split(','));
    }

    if (hasNumbers) {
      _chars.addAll(numbers.split(','));
    }

    if (hasSymbols) {
      _chars.addAll(symbols.split(','));
    }

    _chars.shuffle();

    for (var _i = 0; _i < length; _i++) {
      String _char = _chars[_random.nextInt(_chars.length)];

      _password += _char;
    }

    return _password;
  }

  PasswordGenerator({
    this.hasCapitalLetters = true,
    this.hasSmallLetters = true,
    this.hasNumbers = true,
    this.hasSymbols = true,
    this.length = 10,
  })  : assert(
          hasCapitalLetters || hasNumbers || hasSmallLetters || hasSymbols,
          'At least one of the conditions must be true.',
        ),
        assert(
          length > 0,
          'length must be more than 0.',
        );
}

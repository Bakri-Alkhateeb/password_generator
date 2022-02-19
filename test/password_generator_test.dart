import 'package:password_generator/password_generator.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('A group of test for the PasswordGenerator class', () {
    late final RegExp _smallLetters, _capitalLetters, _numbers, _symbols;

    setUpAll(() {
      _capitalLetters = RegExp(r'[A-Z]');
      _smallLetters = RegExp(r'[a-z]');
      _numbers = RegExp(r'[0-9]');
      _symbols = RegExp(r'[^A-Za-z0-9]');
    });

    test(
        'Should generate a string containing only capital '
        'letters with length of 16', () {
      late final PasswordGenerator _passwordGenerator = PasswordGenerator(
        length: 16,
        hasSymbols: false,
        hasSmallLetters: false,
        hasNumbers: false,
        hasCapitalLetters: true,
      );

      final String _password = _passwordGenerator.generatePassword();

      expect(_password.contains(_capitalLetters), true);
      expect(_password.contains(_smallLetters), false);
      expect(_password.contains(_numbers), false);
      expect(_password.contains(_symbols), false);
      expect(_password.length, 16);
    });

    test(
        'Should generate a string containing only small '
        'letters with length of 16', () {
      late final PasswordGenerator _passwordGenerator = PasswordGenerator(
        length: 16,
        hasSymbols: false,
        hasSmallLetters: true,
        hasNumbers: false,
        hasCapitalLetters: false,
      );

      final String _password = _passwordGenerator.generatePassword();

      expect(_password.contains(_capitalLetters), false);
      expect(_password.contains(_smallLetters), true);
      expect(_password.contains(_numbers), false);
      expect(_password.contains(_symbols), false);
      expect(_password.length, 16);
    });

    test(
        'Should generate a string containing only numbers '
        'with length of 16', () {
      late final PasswordGenerator _passwordGenerator = PasswordGenerator(
        length: 16,
        hasSymbols: false,
        hasSmallLetters: false,
        hasNumbers: true,
        hasCapitalLetters: false,
      );

      final String _password = _passwordGenerator.generatePassword();

      expect(_password.contains(_capitalLetters), false);
      expect(_password.contains(_smallLetters), false);
      expect(_password.contains(_numbers), true);
      expect(_password.contains(_symbols), false);
      expect(_password.length, 16);
    });

    test(
        'Should generate a string containing capital and small '
        'letters, numbers and symbols with length of 16', () {
      late final PasswordGenerator _passwordGenerator = PasswordGenerator(
        length: 16,
        hasSymbols: true,
        hasSmallLetters: true,
        hasNumbers: true,
        hasCapitalLetters: true,
      );

      final String _password = _passwordGenerator.generatePassword();

      expect(_password.contains(_capitalLetters), true);
      expect(_password.contains(_smallLetters), true);
      expect(_password.contains(_numbers), true);
      expect(_password.contains(_symbols), true);
      expect(_password.length, 16);
    });
  });

  group('A group of test for the CheckStrength extension', () {
    late final String _extremelyStrong,
        _veryStrong,
        _strong,
        _ok,
        _weak,
        _extremelyWeak;

    setUpAll(() {
      _extremelyWeak = '1';
      _weak = 'RYWCU';
      _ok = 'ZGFMVI';
      _strong = '4MWAV3D0';
      _veryStrong = 'OzYM\$o^uFp';
      _extremelyStrong = 'M%{a^78w8OP]]TR}hK.[';
    });

    test('Entropy should be less than 18', () {
      expect(_extremelyWeak.checkStrength(), lessThan(18));
    });

    test('Entropy should be more than or equal to 18 and less than 28', () {
      expect(_weak.checkStrength(), lessThan(28));
      expect(_weak.checkStrength(), greaterThanOrEqualTo(18));
    });

    test('Entropy should be more than or equal to 28 and less than 36', () {
      expect(_ok.checkStrength(), lessThan(36));
      expect(_ok.checkStrength(), greaterThanOrEqualTo(28));
    });

    test('Entropy should be more than or equal to 36 and less than 60', () {
      expect(_strong.checkStrength(), lessThan(60));
      expect(_strong.checkStrength(), greaterThanOrEqualTo(36));
    });

    test('Entropy should be more than or equal to 60 and less than 128', () {
      expect(_veryStrong.checkStrength(), lessThan(128));
      expect(_veryStrong.checkStrength(), greaterThanOrEqualTo(60));
    });

    test('Entropy should be more than or equal to 128', () {
      expect(_extremelyStrong.checkStrength(), greaterThanOrEqualTo(128));
    });
  });
}

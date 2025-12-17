import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:test/test.dart';

void main() {
  test('test crypto hash', () {
    const password = '123456';
    final encodedpassword = utf8.encode(password);
    final hash = sha256.convert(encodedpassword);
    print(hash);
  });
}

import 'dart:core';
import 'package:faker/faker.dart';
import 'package:i9vate_sales_force/app/validation/validators/validator.dart';
import 'package:test/test.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Deverá retornar null se o email for vazio.', () {
    final error = sut.validate('');
    expect(error, null);
  });

  test('Deverá retornar null se o email for null.', () {
    final error = sut.validate('');
    expect(error, null);
  });

  test('Deverá retornar null se o email for válido.', () {
    final error = sut.validate(faker.internet.email());
    expect(error, null);
  });

  test('Deverá retornar erro se o email for inválido.', () {
    final error = sut.validate(faker.guid.guid().toString());
    expect(error, 'E-Mail inválido.');
  });
}

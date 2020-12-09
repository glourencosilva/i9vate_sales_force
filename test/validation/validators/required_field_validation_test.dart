import 'package:i9vate_sales_force/app/validation/validators/validator.dart';
import 'package:test/test.dart';

void main() {
  RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Devolverá nulo se o valor não estiver vazio', () {
    final error = sut.validate('any_value');
    expect(error, null);
  });

  test('Erro de retorno exibido se o valor estiver vazio', () {
    final error = sut.validate('');
    expect(error, 'Campo obrigatório');
  });

  test('Devolverá erro se o valor for nulo', () {
    final error = sut.validate(null);
    expect(error, 'Campo obrigatório');
  });
}

import 'package:i9vate_sales_force/app/validation/validators/protocols/protocol.dart';
import 'package:i9vate_sales_force/app/validation/validators/validator.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;

  void mockValidation1(String error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(String error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  void mockValidation3(String error) {
    when(validation3.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);

    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);

    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(null);

    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Deverá retornar null se todas as validações forem nulas ou vazias', () {
    mockValidation2('');
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Deverá retornar o primeiro erro', () {
    mockValidation1('error_1');
    mockValidation2('error_2');
    mockValidation3('error_3');
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_2');
  });
}

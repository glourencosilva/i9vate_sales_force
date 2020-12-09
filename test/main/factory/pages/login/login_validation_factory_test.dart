import 'package:i9vate_sales_force/app/main/factory/factory.dart';
import 'package:i9vate_sales_force/app/validation/validators/validator.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validation.', () {
    final validation = makeLoginValidations();
    expect(validation, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}
